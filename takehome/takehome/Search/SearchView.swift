//
//  SearchView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var inputSearch = ""
    @State private var zip = ""
    @StateObject private var vm = SearchViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    TextField("Search", text: $inputSearch)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .overlay(Image(systemName: "magnifyingglass")
                            .padding(.trailing, 250)
                            .foregroundColor(.blue)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                        )
                        .foregroundColor(.gray)
                        .onSubmit {
                            Task {
                                await vm.searchProducts(query: inputSearch)
                            }
                        }

                    VStack {
                        NavigationLink(destination: CartView(cart: vm.cart, cost: vm.totalCost, count: vm.cartCount)) {
                            Image(systemName: "cart")
                                .font(.title2)
                                .overlay(
                                    Circle()
                                        .fill(.yellow)
                                        .frame(width: 22, height: 22, alignment: .topTrailing)
                                        .overlay(Text("\(vm.cartCount)").font(.caption).foregroundColor(.black))
                                        .offset(x: 10, y: -10)
                                        .font(.subheadline),

                                    alignment: .topTrailing
                                )
                        }
                        .frame(width: 40, height: 44)
                        Text("$\(vm.totalCost, specifier: "%.2f")")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                HStack {
                    Image(systemName: "iphone.gen3.circle")
                    Text("How do you want your items? | ")
                    TextField("Zip", text: $zip)
                        .frame(width: 45, height: 20)
                    Spacer()
                }
                .padding()
            }
            .background(Color.testColorSet)
            .foregroundColor(.white)

            List {
                Section {
                    switch vm.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .success(let results):
                        Text("Results for '\(inputSearch)'")
                            .font(.title)
                        var isFirstItem = true
                        ForEach(results, id: \.self.id) { result in

                            NavigationLink(destination: DetailView(productID: result.id, productName: result.title, productImage: result.thumbnail, productPrice: result.price, productRating: result.rating, productStock: result.stock, productDescription: result.description)) {
                                HStack {
                                    AsyncImage(url: URL(string: result.images[0])) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(8)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Now $\(result.price, specifier: "%.2f")")
                                                .multilineTextAlignment(.leading)
                                                .font(.footnote)
                                                .foregroundColor(.green)
                                                .fontWeight(.bold)
                                            Text("\(result.price / (1 - (result.discountPercentage / 100)), specifier: "%.2f")")
                                                .font(.caption2)
                                                .strikethrough()
                                        }
                                        Text("\(result.description)")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                        Text("")
                                        HStack {
                                            StarRatingView(rating: result.rating)
                                                .font(.caption)
                                            Text("3,225")
                                                .font(.caption2)
                                        }
                                        Text("")
                                        Text("Free shipping, arrives in 2 days")
                                            .font(.caption)
                                        Button(action: {
                                            vm.addToTotalCost(price: result.price)
                                            vm.addToCartCount(count: 1)
                                            vm.appendToCart(product: result)
                                        }) {
                                            Text("Add to cart")
                                                .padding()
                                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                                .font(.caption)
                                                .padding()
                                        }
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    case .error(let error):
                        Text("An error occurred: \(error.localizedDescription)")
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    SearchView()
}
