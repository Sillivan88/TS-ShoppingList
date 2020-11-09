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
    
    var body: some View {
        List {
            ForEach(markets) { market in
                Text(market.name ?? "")
            }
        }
        .navigationTitle("Markets")
    }
}

struct MarketsList_Previews: PreviewProvider {
    static var previews: some View {
        MarketsList()
    }
}
