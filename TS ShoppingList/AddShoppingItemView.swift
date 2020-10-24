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
            Form {
                TextField("Shopping item", text: $shoppingItemDummy.name)
                Toggle("Is favorite", isOn: $shoppingItemDummy.isFavorite)
            }
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

struct AddShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItemView(showAddShoppingItemView: .constant(false))
    }
}
