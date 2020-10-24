//
//  ContentView.swift
//  TS ShoppingList
//
//  Created by Trainer on 21.09.20.
//

import SwiftUI

struct ContentView: View {
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
    
    var body: some View {
        List {
            ForEach(shoppingItems) { shoppingItem in
                ShoppingCell(shoppingItem: shoppingItem)
            }
            .onDelete { (indexSet) in
                for index in indexSet {
                    let shoppingItemToDelete = shoppingItems[index]
                    PersistenceController.shared.container.viewContext.delete(shoppingItemToDelete)
                    try? PersistenceController.shared.container.viewContext.save()
                }
            }
        }
        .navigationTitle("Shopping List")
        .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
            showAddShoppingItemView = true
        })
        .sheet(isPresented: $showAddShoppingItemView, content: {
            AddShoppingItemView(showAddShoppingItemView: $showAddShoppingItemView)
        })
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ShoppingCell(shoppingItem: PersistenceController.testShoppingItem)
                .previewLayout(.sizeThatFits)
        }
    }
}
