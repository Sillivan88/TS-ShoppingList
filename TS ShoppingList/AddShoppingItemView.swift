//
//  AddShoppingItemView.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.09.20.
//

import SwiftUI

struct AddShoppingItemView: View {
    @State private var shoppingItemTitle = ""
    
    @Binding var showAddShoppingItemView: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Shopping item", text: $shoppingItemTitle)
            }
            .navigationTitle("Add shopping item")
            .navigationBarItems(
                leading: Button("Cancel") {
                    showAddShoppingItemView = false
                },
                trailing: Button("Save") {
                    // TODO: Save shopping item.
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
