//
//  DetailView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import SwiftUI

struct DetailView: View {
    let productID: Int
    let productName: String
    let productImage: String
    let productPrice: Double
    let productRating: Double
    let productStock: Int
    let productDescription: String
    @StateObject private var vm = DetailViewModel()
    var body: some View {
        NavigationStack {
            //        Text("Recipe details for \(recipeID)")

            VStack {
                HStack {
                    Spacer()
                    Text(productName)
                        .font(.title)
                        .padding()
                    StarRatingView(rating: productRating)
                        .font(.title2)
                    Spacer()
                }
                .padding()
            }
            .background(Color.testColorSet)
            .foregroundColor(.white)
            List {
                Section {
                    AsyncImage(url: URL(string: productImage))
                    VStack(alignment: .center) {
                        HStack(alignment: .center) {
                            Spacer()
                            VStack {
                                Text("Price")
                                    .font(.title2)
                                Text("$\(productPrice, specifier: "%.2f")")
                                    .font(.callout)
                            }
                            Spacer()
                            VStack {
                                Text("Stock")
                                    .font(.title2)
                                Text("\(productStock)")
                                    .font(.callout)
                            }
                            Spacer()
                        }
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Text("Description")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(productDescription)")
                        Spacer()
                    }
                }
                Section {
                    switch vm.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .success(let results):
                        HStack {
                            Spacer()
                            Text("Comments")
                                .font(.title2)
                            Spacer()
                        }
                        ForEach(results, id: \.self.id) { result in
                            HStack {
                                Spacer()
                                VStack {
                                    Text("\(result.user.username):")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                    Text("\(result.body)")
                                        .font(.callout)
                                        .lineLimit(3)
                                }
                                Spacer()
                            }
                        }
                    case .error(let error):
                        Text("An error occurred: \(error.localizedDescription)")
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listRowSeparator(.hidden)
        }
        .task {
            await vm.searchProducts()
        }
    }
}

#Preview {
    DetailView(productID: 5, productName: "Prod", productImage: "https://hws.dev/paul.jpg", productPrice: 4.00, productRating: 3.57, productStock: 52, productDescription: "Hello World")
}
