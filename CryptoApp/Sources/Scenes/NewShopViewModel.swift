//
//  NewShopViewModel.swift
//  CryptoApp
//
//  Created by Игорь Николаев on 23.04.2023.
//

import Foundation

class ShopViewModel: ObservableObject {

    @Published var shops = [Shop]() {
        didSet {
            saveShop()
        }
    }

    @Published var accountName = "" {
        didSet {
            updateSaveButtonColor()
        }
    }

    @Published var apiKey = "" {
        didSet {
            updateSaveButtonColor()
        }
    }

    @Published var saveIsEnabled = false

    let localStorage: LocalStorageType

    init(localStorage: LocalStorageType) {
        self.localStorage = localStorage
        getShop()
    }

    private var allFieldsFilled: Bool {
        return !accountName.isEmpty && !apiKey.isEmpty
    }

    private func updateSaveButtonColor() {
        saveIsEnabled = allFieldsFilled
    }

    private func saveShop() {
        let localStorage = LocalStorage(userDefaults: .standard)

        if let encodedData = try? JSONEncoder().encode(shops) {
            localStorage.save(encodedData, for: "shop_list")
        }
    }

    func createShop() {
        let shop = Shop(id: UUID(), title: accountName)
        shops.append(shop)
    }

    func getShop() {
        let localStorage = LocalStorage(userDefaults: .standard)
        guard let data = localStorage.fetchValue(type: Data.self, for: "shop_list"),
              let shops = try? JSONDecoder().decode([Shop].self, from: data)
        else {
            return
        }
        self.shops = shops
    }
}
