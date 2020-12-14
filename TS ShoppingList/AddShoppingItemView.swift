//
//  AddShoppingItemView.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.09.20.
//

import SwiftUI

struct ShoppingItemDummy {
    var name = ""
    var isFavorite = false
}

struct AddShoppingItemView: View {
    @State private var shoppingItemDummy = ShoppingItemDummy()
    
    @Binding var showAddShoppingItemView: Bool
    
    var body: some View {
        NavigationView {
            ShoppingItemView(name: $shoppingItemDummy.name, isFavorite: $shoppingItemDummy.isFavorite)
            .navigationTitle("Add shopping item")
            .navigationBarItems(
                leading: Button("Cancel") {
                    showAddShoppingItemView = false
                },
                trailing: Button("Save") {
                    ShoppingItemManager.shared.addShoppingItem(fromDummy: shoppingItemDummy)
                    showAddShoppingItemView = false
                }
            )
        }
    }
}

struct EditShoppingItemView: View {
    @ObservedObject var shoppingItem: ShoppingItem
    
    var body: some View {
        ShoppingItemView(name: $shoppingItem.name.toNonOptionalString(), isFavorite: $shoppingItem.isFavorite)
        .navigationTitle("Edit shopping item")
        .onDisappear {
            PersistenceController.shared.saveContext()
        }
    }
}

struct ShoppingItemView: View {
    @Binding var name: String
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        Form {
            TextField("Shopping item", text: $name)
            Toggle("Is favorite", isOn: $isFavorite)
        }
    }
}

struct AddShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItemView(showAddShoppingItemView: .constant(false))
    }
}
