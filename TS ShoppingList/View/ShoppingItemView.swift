//
//  ShoppingItemView.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.09.20.
//

import SwiftUI

struct ShoppingItemView: View {
    @Binding var name: String
    
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
                Toggle("Is favorite", isOn: $isFavorite)
            }
            Section {
                TextField("Price", value: $price, formatter: currencyFormatter)
            }
        }
    }
}

struct ShoppingItemDummy {
    var name = ""
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
            isFavorite: $shoppingItem.isFavorite,
            price: $shoppingItem.price
        )
        .navigationTitle("Edit shopping item")
        .onDisappear {
            shoppingItemManager.saveContext()
        }
    }
}

struct ShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItemView(showAddShoppingItemView: .constant(false))
            .environmentObject(ShoppingItemManager(usePreview: true))
    }
}
