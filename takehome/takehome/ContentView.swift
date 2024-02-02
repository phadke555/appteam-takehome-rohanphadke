//
//  ContentView.swift
//  takehome
//
//  Created by Rohan Phadke on 2/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ShopView()
                .tabItem {
                    Label("Shop", systemImage: "house.lodge")
                }
            MyItemView()
                .tabItem {
                    Label("My Items", systemImage: "heart")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "text.magnifyingglass")
                }
            ServicesView()
                .tabItem {
                    Label("Services", systemImage: "circle.hexagongrid")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
