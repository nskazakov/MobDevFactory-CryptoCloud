//
//  LocalStorage.swift
//

import Foundation

protocol LocalStorageType {
    func save<T>(_ value: T, for key: String)
    func removeValue(for key: String)
    func fetchValue<T>(type: T.Type, for key: String) -> T?
}

final class LocalStorage: LocalStorageType {

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func save<T>(_ value: T, for key: String) {
        userDefaults.set(value, forKey: key)
    }

    func removeValue(for key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func fetchValue<T>(type: T.Type, for key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }
}
