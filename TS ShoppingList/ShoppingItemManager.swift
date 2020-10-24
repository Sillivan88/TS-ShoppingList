//
//  ShoppingItemManager.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.10.20.
//

import Foundation

class ShoppingItemManager {
    
    static let shared = ShoppingItemManager()
    
    private init() {}
    
    func addShoppingItem(fromDummy dummy: ShoppingItemDummy) {
        addShoppingItem(withName: dummy.name, isFavorite: dummy.isFavorite)
    }
    
    func addShoppingItem(withName name: String, isFavorite: Bool) {
        let shoppingItem = ShoppingItem(context: PersistenceController.shared.managedObjectContext)
        shoppingItem.name = name
        shoppingItem.isFavorite = isFavorite
        PersistenceController.shared.saveContext()
    }
    
    func delete(shoppingItem: ShoppingItem) {
        PersistenceController.shared.managedObjectContext.delete(shoppingItem)
        PersistenceController.shared.saveContext()
    }
    
}
