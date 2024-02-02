//
//  DetailViewModel.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

enum DetailLoadingState {
    case idle
    case loading
    case success(results: [Comment])
    case error(error: Error)
}

import Foundation

class DetailViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var state: DetailLoadingState = .idle

    func searchProducts() async {
        do {
            self.state = .loading
            let result = try await SingleSearchService.findComments()
            self.state = .success(results: result)
        } catch {
            self.state = .error(error: error)
            print("Error: \(error)")
        }
    }
}
