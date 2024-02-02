//
//  SearchView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import SwiftUI

struct SearchView: View {
    @State private var inputSearch = ""
    @State private var zip = ""
    @StateObject private var vm = SearchViewModel()
    var body: some View {
        VStack {
//            ZStack {
//                Rectangle()
//                    .foregroundColor(.blue)
//                    .ignoresSafeArea(edges: .top)
//                    .frame(height:100)
                
                VStack {
                    HStack(spacing: 0) {
                        TextField("Search", text: $inputSearch)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .overlay(Image(systemName: "magnifyingglass")
                                .padding(.trailing, 100)
                            )
                            .onSubmit {
                                Task {
                                    await vm.searchProducts()
                                }
                            }

                        //                Button("Fetch Data") {
                        //                    Task {
                        //                        await vm.searchProducts()
                        //                    }
                        //                }
                        Image(systemName: "cart")
                    }
                    HStack {
                        Text("How do you want your items? |")
                        TextField("Zip", text: $zip)
                            .frame(width: 60, height: 20)
                    }
                }
            

            List {
                switch vm.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .success(let results):
                    Text("Results for \(inputSearch)")
                        .font(.title)
                    ForEach(results, id: \.self.id) { result in
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

                                Text("Now $\(result.price, specifier: "%.2f")")
                                    .multilineTextAlignment(.leading)
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                                Text("\(result.description)")
                                    .multilineTextAlignment(.leading)
                                    .font(.caption)
                                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                Text("")
                                HStack {
                                    StarRatingView(rating: result.rating)
                                    Text("3,135")
                                        .font(.caption2)
                                }
                                Text("")
                                Text("Free shipping, arrives in 2 days")
                                    .font(.caption2)
                                Button {}
                                    label: {
                                        Text("Add to cart")
                                            .foregroundColor(.blue)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                            }
                        }
                    }
                case .error(let error):
                    Text("An error occurred: \(error.localizedDescription)")
                }
                
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    SearchView()
}
