//
//  MarketsList.swift
//  TS ShoppingList
//
//  Created by Trainer on 09.11.20.
//

import SwiftUI

struct MarketsListNavigationView: View {
    var body: some View {
        NavigationView {
            MarketsList()
        }
    }
}

struct MarketsList: View {
    @FetchRequest(
        entity: Market.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var markets: FetchedResults<Market>
    
    @State private var showAddMarketView = false
    
    var body: some View {
        List {
            ForEach(markets) { market in
                Text(market.name ?? "")
            }
        }
        .navigationBarItems(trailing: Button("Add") {
            showAddMarketView = true
        })
        .navigationTitle("Markets")
        .sheet(isPresented: $showAddMarketView) {
            AddMarketView(showAddMarketView: $showAddMarketView)
        }
    }
}

struct MarketsList_Previews: PreviewProvider {
    static var previews: some View {
        MarketsList()
    }
}
