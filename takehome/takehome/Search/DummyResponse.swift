//
//  DummyResponse.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

import Foundation


struct Cart: Codable {
    var cost: Double
    var count: Int
    var products: [Product]
}

struct DummyResponse: Codable {
    var products: [Product]
}


struct Product: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    var images: [String]
}

