//
//  ShoppingItemsListNavigationView.swift
//  TS ShoppingList
//
//  Created by Trainer on 09.11.20.
//

import SwiftUI

struct ShoppingItemsListNavigationView: View {
    @State private var showAddShoppingItemView = false
    
    var body: some View {
        NavigationView {
            ShoppingItemsList(showAddShoppingItemView: $showAddShoppingItemView)
        }
    }
}

struct ShoppingItemsList: View {
    @FetchRequest(
        entity: ShoppingItem.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var shoppingItems: FetchedResults<ShoppingItem>
    
    @Binding var showAddShoppingItemView: Bool
    
    @EnvironmentObject var shoppingItemManager: ShoppingItemManager
    
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List {
            ForEach(shoppingItems) { shoppingItem in
                ShoppingNavigationCell(shoppingItem: shoppingItem)
            }
            .onDelete { (indexSet) in
                for index in indexSet {
                    let shoppingItemToDelete = shoppingItems[index]
                    shoppingItemManager.delete(shoppingItem: shoppingItemToDelete)
                }
            }
        }
        .navigationTitle("Shopping List")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomEditButton()
                    .disabled(shoppingItems.isEmpty)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                AddShoppingItemButton(showAddShoppingItemView: $showAddShoppingItemView)
            }
        }
        .sheet(isPresented: $showAddShoppingItemView, content: {
            AddShoppingItemView(showAddShoppingItemView: $showAddShoppingItemView)
                .environmentObject(shoppingItemManager)
        })
    }
}

struct ShoppingNavigationCell: View {
    let shoppingItem: ShoppingItem
    
    var body: some View {
        NavigationLink(destination: EditShoppingItemView(shoppingItem: shoppingItem)) {
            ShoppingCell(shoppingItem: shoppingItem)
        }
    }
}

struct ShoppingCell: View {
    @ObservedObject var shoppingItem: ShoppingItem
    
    var body: some View {
        HStack {
            Button(action: {
                shoppingItem.isChecked.toggle()
            }) {
                Image(systemName: shoppingItem.isChecked ? "largecircle.fill.circle" : "circle")
            }
            .buttonStyle(PlainButtonStyle())
            Text(shoppingItem.name ?? "")
            Spacer()
            if shoppingItem.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct ShoppingItemsListNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ShoppingItemsListNavigationView()
                .environment(\.managedObjectContext, PersistenceController.preview.managedObjectContext)
                .environmentObject(ShoppingItemManager(usePreview: true))
            ShoppingCell(shoppingItem: PersistenceController.testShoppingItem)
                .previewLayout(.sizeThatFits)
        }
    }
}
