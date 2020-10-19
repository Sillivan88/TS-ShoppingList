//
//  AddShoppingItemView.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.09.20.
//

import SwiftUI

struct AddShoppingItemView: View {
    struct ShoppingItemDummy {
        var name = ""
    }
    
    @State private var shoppingItemDummy = ShoppingItemDummy()
    
    @Binding var showAddShoppingItemView: Bool
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Shopping item", text: $shoppingItemDummy.name)
            }
            .navigationTitle("Add shopping item")
            .navigationBarItems(
                leading: Button("Cancel") {
                    showAddShoppingItemView = false
                },
                trailing: Button("Save") {
                    let shoppingItem = ShoppingItem(context: PersistenceController.shared.container.viewContext)
                    shoppingItem.name = shoppingItemDummy.name
                    try? PersistenceController.shared.container.viewContext.save()
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
