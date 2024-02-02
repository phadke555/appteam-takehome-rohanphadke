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
    var body: some View {
        List {
            Section {
                Text("Cart")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("Total: $\(cost, specifier: "%.2f")")
            }
            
            if cost > 0.00 {
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
                                    //                            AsyncImage(url: URL(string: result.images[0]))
                                    //                                .frame(width:10, height:5)
                                    HStack {
                                        Text("Now $\(result.price, specifier: "%.2f")")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                            .foregroundColor(.green)
                                        Text("\(result.price / (1 - (result.discountPercentage / 100)), specifier: "%.2f")")
                                            .font(.footnote)
                                            .strikethrough()
                                    }
                                    Text("\(result.description)")
                                        .multilineTextAlignment(.leading)
                                        .font(.caption2)
                                        .lineLimit(2)
                                    Text("")
                                    HStack {
                                        StarRatingView(rating: result.rating)
                                            .font(.caption2)
                                        //                                            Text("3,135")
                                        //                                                .font(.caption2)
                                    }
                                    Text("")
                                    Text("Free shipping, arrives in 2 days")
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }
            else{
                Text("Cart is currently empty. Add to the cart!")
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    CartView(cart: [Product(id: 5, title: "Prod", description: "Hello World", price: 4.00, discountPercentage: 3.00, rating: 3.57, stock: 52, brand: "Equate", category: "something", thumbnail: "https://hws.dev/paul.jpg", images: ["https://hws.dev/paul.jpg"])], cost: 0)
}
