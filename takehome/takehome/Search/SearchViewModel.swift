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
    @Published  var query: String = ""
    @Published var state: SearchLoadingState = .idle
    
    func searchProducts() async{
        do{
            self.state = .loading
            let result = try await ProductSearchService.findProducts()
            self.state = .success(results: result)
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }
    }
}
