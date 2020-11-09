//
//  ContentView.swift
//  TS ShoppingList
//
//  Created by Trainer on 21.09.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ShoppingItemsListNavigationView()
                .tabItem {
                    Text("Shopping List")
                    Image(systemName: "cart.fill")
                }
            MarketsListNavigationView()
                .tabItem {
                    Text("Markets")
                    Image(systemName: "building.2.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
