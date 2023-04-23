//
//  ShopListViewModel.swift
//  CryptoApp
//
//  Created by Kristina Korotkova on 09/04/23.
//

import Foundation

final class ShopListViewModel: ObservableObject {

    @Published var models = [Shop]()

    init() {
        getData()
    }

    func getData() {
        let newData = [
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1"),
            Shop(id: UUID(),
                 icon: "cat",
                 title: "Bank 1")
        ]
        models = newData
    }
}

