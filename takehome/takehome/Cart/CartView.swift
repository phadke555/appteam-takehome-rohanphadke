//
//  CartView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import SwiftUI

struct CartView: View {
    let cart: [Product]
    let cost: Double
    let count: Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Your Cart")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("Total: $\(cost, specifier: "%.2f")")
                    Text("Items: \(count)")
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.testColorSet)
        .foregroundColor(.white)

        List {
            if cost > 0.00 || count > 0 {
                Section {
                    ForEach(cart, id: \.self.id) { result in
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
                                    Text("\(result.title)")
                                        .font(.callout)
                                    HStack {
                                        Text("Now $\(result.price, specifier: "%.2f")")
                                            .multilineTextAlignment(.leading)
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            .foregroundColor(.green)
                                        Text("$\(result.price / (1 - (result.discountPercentage / 100)), specifier: "%.2f")")
                                            .font(.caption2)
                                            .strikethrough()
                                    }
                                    Text("\(result.description)")
                                        .multilineTextAlignment(.leading)
                                        .font(.caption)
                                        .lineLimit(2)
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
                                }
                            }
                        }
                    }
                }
            }
            else {
                Section {
                    Text("Cart is currently empty. Add to the cart!")
                }
            }
            Section{
                HStack{
                    Spacer()
                    Button(action: {
                        // Action to perform on button tap
                        print("Checkout button tapped.")
                        // Here, you can place your code to proceed to the checkout process
                    }) {
                        Text("Checkout")
                            .font(.headline)
                            .padding()
                            .background(Color.testColorSet)
                            .foregroundColor(.white)
                            .cornerRadius(10) // Adds rounded corners to the button
                    }
                    Spacer()
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    CartView(cart: [Product(id: 5, title: "Prod", description: "Hello World", price: 4.00, discountPercentage: 3.00, rating: 3.57, stock: 52, brand: "Equate", category: "something", thumbnail: "https://hws.dev/paul.jpg", images: ["https://hws.dev/paul.jpg"])], cost: 0, count: 1)
}
