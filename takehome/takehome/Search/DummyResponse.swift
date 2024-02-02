//
//  DummyResponse.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

import Foundation




struct DummyResponse: Codable {
    let products: [Product]
}


struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

