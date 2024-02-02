//
//  SingleSearchService.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import Foundation

struct SingleSearchService {
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    public static func findComments(
    ) async throws -> [Comment] {
        var components = URLComponents(string: "https://dummyjson.com/comments")!
        guard let url = components.url else {
            fatalError("Invalid URL Error")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        let (data, _) = try await session.data(for: request)
        let dummyResponse = try decoder.decode(CommentsResponse.self, from: data)
        printData(data: data)
        return dummyResponse.comments
    }

    private static func printData(data: Data) {
        let string = String(data: data, encoding: .utf8)!
        print(string)
    }
}
