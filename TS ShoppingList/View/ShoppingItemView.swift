//
//  ShoppingItemView.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.09.20.
//

import SwiftUI

struct ShoppingItemView: View {
    @Binding var name: String
    
    @Binding var market: Market?
    
    @Binding var isFavorite: Bool
    
    @Binding var price: Double
    
    private let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
    
    var body: some View {
        Form {
            Section {
                TextField("Shopping item", text: $name)
                MarketPicker(market: $market)
                Toggle("Is favorite", isOn: $isFavorite)
            }
            Section {
                TextField("Price", value: $price, formatter: currencyFormatter)
            }
        }
    }
}

struct MarketPicker: View {
    @FetchRequest(
        entity: Market.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    ) private var markets: FetchedResults<Market>
    
    @Binding var market: Market?
    
    var body: some View {
        Picker("Market", selection: $market) {
            ForEach(markets) { market in
                Text(market.name ?? "")
                    .tag(market as Market?)
            }
        }
    }
}

struct ShoppingItemDummy {
    var name = ""
    var market: Market? = nil
    var isFavorite = false
    var price: Double = 0
}

struct AddShoppingItemView: View {
    @State private var shoppingItemDummy = ShoppingItemDummy()
    
    @Binding var showAddShoppingItemView: Bool
    
    @EnvironmentObject var shoppingItemManager: ShoppingItemManager
    
    var body: some View {
        NavigationView {
            ShoppingItemView(
                name: $shoppingItemDummy.name,
                market: $shoppingItemDummy.market,
                isFavorite: $shoppingItemDummy.isFavorite,
                price: $shoppingItemDummy.price
            )
            .navigationTitle("Add shopping item")
            .navigationBarItems(
                leading: Button("Cancel") {
                    showAddShoppingItemView = false
                },
                trailing: Button("Save") {
                    shoppingItemManager.addShoppingItem(fromDummy: shoppingItemDummy)
                    showAddShoppingItemView = false
                }
            )
        }
    }
}

struct EditShoppingItemView: View {
    @ObservedObject var shoppingItem: ShoppingItem
    
    @EnvironmentObject var shoppingItemManager: ShoppingItemManager
    
    var body: some View {
        ShoppingItemView(
            name: $shoppingItem.name.toNonOptionalString(),
            market: $shoppingItem.market,
            isFavorite: $shoppingItem.isFavorite,
            price: $shoppingItem.price
        )
        .navigationTitle("Edit shopping item")
        .onDisappear {
            shoppingItemManager.saveContext()
        }
    }
}

struct AddShoppingItemButton: View {
    @Binding var showAddShoppingItemView: Bool
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button("Add") {
            showAddShoppingItemView = true
        }
        .disabled(editMode?.wrappedValue.isEditing ?? false)
    }
}

struct ShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItemView(showAddShoppingItemView: .constant(false))
            .environmentObject(ShoppingItemManager(usePreview: true))
    }
}
