//
//  MarketView.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

struct MarketView: View {
    @ObservedObject var market: Market
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $market.name.toNonOptionalString())
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $market.notes.toNonOptionalString())
                    .frame(height: 300)
            }
        }
    }
}

struct EditMarketView: View {
    @ObservedObject var market: Market
    
    @EnvironmentObject var marketManager: MarketManager
    
    var body: some View {
        MarketView(market: market)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        marketManager.saveContext()
                        market.objectWillChange.send()
                    }
                    .disabled(!market.hasChanges)
                }
            }
            .onDisappear {
                if market.hasChanges {
                    marketManager.managedObjectContext.refresh(market, mergeChanges: false)
                }
            }
    }
}

struct AddMarketView: View {
    private var newMarket: StateObject<Market>
    
    @State private var didDisappearWithButton = false
    
    var showAddMarketView: Binding<Bool>
    
    let marketManager: MarketManager
    
    init(showAddMarketView: Binding<Bool>, marketManager: MarketManager) {
        self.showAddMarketView = showAddMarketView
        self.marketManager = marketManager
        newMarket = StateObject<Market>(wrappedValue: Market(context: marketManager.managedObjectContext))
    }
    
    var body: some View {
        NavigationView {
            MarketView(market: newMarket.wrappedValue)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            hideAddMarketView(shouldSaveNewMarket: false)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            hideAddMarketView(shouldSaveNewMarket: true)
                        }
                    }
                }
        }
        .onDisappear {
            if !didDisappearWithButton {
                hideAddMarketView(shouldSaveNewMarket: false)
            }
        }
    }
    
    private func hideAddMarketView(shouldSaveNewMarket: Bool) {
        didDisappearWithButton = true
        if shouldSaveNewMarket {
            marketManager.saveContext()
        } else {
            marketManager.delete(market: newMarket.wrappedValue)
        }
        showAddMarketView.wrappedValue = false
    }
}

struct AddMarketView_Previews: PreviewProvider {
    static var previews: some View {
        AddMarketView(showAddMarketView: .constant(true), marketManager: MarketManager(usePreview: true))
    }
}
