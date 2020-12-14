//
//  AddMarketView.swift
//  TS ShoppingList
//
//  Created by Trainer on 14.11.20.
//

import SwiftUI

struct AddMarketView: View {
    @StateObject private var newMarket = Market(context: PersistenceController.shared.managedObjectContext)
    
    @State private var didDisappearWithButton = false
    
    @Binding var showAddMarketView: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $newMarket.name.toNonOptionalString())
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: $newMarket.notes.toNonOptionalString())
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
            PersistenceController.shared.saveContext()
        } else {
            MarketManager.shared.delete(market: newMarket)
        }
        showAddMarketView = false
    }
}

struct AddMarketView_Previews: PreviewProvider {
    static var previews: some View {
        AddMarketView(showAddMarketView: .constant(true))
    }
}
