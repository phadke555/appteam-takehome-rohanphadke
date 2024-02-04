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
    @Published var cartCount: Int = 0
    @Published var userCart: Cart = .init(cost: 0.0, count: 0, products: []) {
        didSet {
            print(self.userCart)
            self.saveCart()
        }
    }

    @Published var query: String = ""
    @Published var state: SearchLoadingState = .idle
    private let cartKey: String = "cart"

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
        self.userCart.cost += price
    }
    
    func addToCartCount(count: Int) {
        self.cartCount += 1
        self.userCart.count += 1
    }
    
    func appendToCart(product: Product) {
        self.cart.append(product)
        self.userCart.products.append(product)
    }
    
    private func saveCart() {
        do {
            let data = try JSONEncoder().encode(self.userCart)
            UserDefaults.standard.set(data, forKey: self.cartKey)
            print(self.userCart)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    init() {
        self.loadCart()
    }

    func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey) else {
            return // Or handle the absence of data appropriately
        }
        do {
            let values = try JSONDecoder().decode(Cart.self, from: data)
            self.userCart = values
        } catch {
            print("Error decoding data: \(error)")
        }
    }
}
