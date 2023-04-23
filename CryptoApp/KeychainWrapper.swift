//
//  KeychainWrapper.swift
//

import Foundation
import Security

enum KeychainError: Error {
    case valueNotFound
    case statusNotSuccess(OSStatus)
    case invalidData
    case parsingFailed(String?)
}

protocol KeychainWrapperType {

    var value: String? { get }

    func persist(value: String)
    func clear()
    func fetchValue() throws -> String
}

final class KeychainWrapper {

    private let secureItemDescription: String
    private let accessGroup: String
    private let accountName: String
    private let serviceName: String

    private var cachedValue: String?

    private lazy var searchQuery = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccessGroup: accessGroup,
        kSecAttrService: serviceName,
        kSecAttrAccount: accountName,
        kSecMatchLimit: kSecMatchLimitOne,
        kSecReturnData: true,
        kSecReturnAttributes: true
    ] as CFDictionary

    private lazy var basicSearchQuery = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrAccessGroup: accessGroup,
        kSecAttrService: serviceName,
        kSecAttrAccount: accountName
    ] as CFDictionary

    init(
        secureItemDescription: String,
        accessGroup: String,
        serviceName: String,
        accountName: String
    ) {
        self.secureItemDescription = secureItemDescription
        self.accessGroup = accessGroup
        self.serviceName = serviceName
        self.accountName = accountName
    }
}

// MARK: - KeychainWrapperType

extension KeychainWrapper: KeychainWrapperType {

    var value: String? {
        guard cachedValue == nil else { return cachedValue }
        cachedValue = try? fetchValue()
        return cachedValue
    }

    func persist(value: String) {
        guard let data = try? NSKeyedArchiver.archivedData(
            withRootObject: value,
            requiringSecureCoding: true
        ) else { return }

        let attributes = [
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecValueData: data,
            kSecAttrDescription: secureItemDescription
        ] as CFDictionary

        var status = SecItemUpdate(basicSearchQuery, attributes)

        if status == errSecItemNotFound {
            let attributes = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                kSecAttrAccessGroup: accessGroup,
                kSecAttrService: serviceName,
                kSecAttrAccount: accountName,
                kSecValueData: data,
                kSecAttrDescription: secureItemDescription
            ] as CFDictionary

            status = SecItemAdd(attributes, nil)
        }

        if status == errSecSuccess {
            cachedValue = value
        }
    }

    func clear() {
        cachedValue = nil
        let status = SecItemDelete(basicSearchQuery)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return print("Somehow failed to clear Auth token")
        }
    }

    func fetchValue() throws -> String {
        var item: CFTypeRef?

        let status = SecItemCopyMatching(searchQuery, &item)

        if status == errSecItemNotFound {
            throw KeychainError.valueNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainError.statusNotSuccess(status)
        }

        guard let dictionary = item as? [CFString: Any],
              let data = dictionary[kSecValueData] as? Data else {
            throw KeychainError.invalidData
        }

        guard let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? String else {
            throw KeychainError.parsingFailed(String(data: data, encoding: .utf8))
        }

        return value
    }
}
