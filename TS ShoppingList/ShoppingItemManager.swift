//
//  ShoppingItemManager.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.10.20.
//

import Foundation

class ShoppingItemManager: PersistenceManager {
    
    func addShoppingItem(fromDummy dummy: ShoppingItemDummy) {
        addShoppingItem(withName: dummy.name, isFavorite: dummy.isFavorite)
    }
    
    func addShoppingItem(withName name: String, isFavorite: Bool) {
        let shoppingItem = ShoppingItem(context: managedObjectContext)
        shoppingItem.name = name
        shoppingItem.isFavorite = isFavorite
        saveContext()
    }
    
    func delete(shoppingItem: ShoppingItem) {
        managedObjectContext.delete(shoppingItem)
        saveContext()
    }
    
}
