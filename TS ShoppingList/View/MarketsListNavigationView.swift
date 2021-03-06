//
//  MarketsListNavigationView.swift
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
    
    @EnvironmentObject var marketManager: MarketManager
    
    var body: some View {
        List {
            ForEach(markets) { market in
                MarketCell(market: market)
            }
        }
        .navigationTitle("Markets")
        .sheet(isPresented: $showAddMarketView) {
            AddMarketView(showAddMarketView: $showAddMarketView, marketManager: marketManager)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    showAddMarketView = true
                }
            }
        }
    }
}

struct MarketCell: View {
    @ObservedObject var market: Market
    
    var body: some View {
        NavigationLink(market.name ?? "", destination: EditMarketView(market: market))
    }
}

struct MarketsListNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MarketsListNavigationView()
            .environment(\.managedObjectContext, PersistenceController.preview.managedObjectContext)
            .environmentObject(MarketManager(usePreview: true))
    }
}
