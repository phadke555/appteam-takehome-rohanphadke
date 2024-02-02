//
//  ProductSearchService.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

import Foundation

struct ProductSearchService {
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    public static func findProducts(
    ) async throws -> [Product] {
        var components = URLComponents(string: "https://dummyjson.com/products")!
        guard let url = components.url else {
            fatalError("Invalid URL Error")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        let (data, _) = try await session.data(for: request)
        let dummyResponse = try decoder.decode(DummyResponse.self, from: data)
        printData(data: data)
        return dummyResponse.products
    }

    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
