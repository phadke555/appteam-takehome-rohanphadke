//
//  SearchViewModel.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

enum SearchLoadingState {
    case idle
    case loading
    case success(results: [Product])
    case error(error: Error)
}

import Foundation

class SearchViewModel: ObservableObject {
    @Published var cart: [Product] = []
    @Published var totalCost: Double = 0.0
    @Published var query: String = ""
    @Published var state: SearchLoadingState = .idle

    func searchProducts(
        query: String
    ) async {
        do {
            self.state = .loading
            let result = try await ProductSearchService.findProducts(query: query)
            self.state = .success(results: result)
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }
    }

    func addToTotalCost(price: Double) {
        self.totalCost += price
    }
    
    func appendToCart(product: Product){
        cart.append(product)
    }
}
