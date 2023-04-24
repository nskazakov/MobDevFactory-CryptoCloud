//
//  Shop.swift
//  CryptoApp
//
//  Created by Kristina Korotkova on 09/04/23.
//

import Foundation

struct Shop: Codable, Identifiable {
    let id: UUID
    let title: String?
    var description: String?
    var imageURL: String?
}
