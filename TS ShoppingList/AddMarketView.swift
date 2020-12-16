//
//  AddMarketView.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

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
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: newMarket.projectedValue.name.toNonOptionalString())
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: newMarket.projectedValue.notes.toNonOptionalString())
                        .frame(height: 300)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    hideAddMarketView(shouldSaveNewMarket: false)
                },
                trailing: Button("Save") {
                    hideAddMarketView(shouldSaveNewMarket: true)
                }
            )
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
