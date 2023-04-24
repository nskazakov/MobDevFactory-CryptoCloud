//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Kristina Korotkova on 09/04/23.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ShopListView(viewModel: ShopViewModel(localStorage: LocalStorage(userDefaults: .standard)))
        }
    }
}

/*
 Shop {
    id: UUID
    title: String
    description: String
    imageURL: String
 }

 ShopEncrypt {
    id: UUID
    apiKey: String
 }

 KeychainWrapper {
    save(_ value: String, forKey: String)
    get...
 }

 -> SAVE
 Create Shop
 UD get shops
 shops.append(shop)
 UD update(shops, forKey: "ShopList")
 KeychainWrapper().save(apiKey, forKey: shop.id.stringValue)

 -> ShopList
 updateShopList() -> UD getShops...
 */
