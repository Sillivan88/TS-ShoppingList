//
//  ShoppingItemManager.swift
//  TS ShoppingList
//
//  Created by Trainer on 24.10.20.
//

import Foundation

class ShoppingItemManager: PersistenceManager {
    
    func addShoppingItem(fromDummy dummy: ShoppingItemDummy) {
        addShoppingItem(withName: dummy.name, market: dummy.market, isFavorite: dummy.isFavorite, price: dummy.price)
    }
    
    func addShoppingItem(withName name: String, market: Market?, isFavorite: Bool, price: Double) {
        let shoppingItem = ShoppingItem(context: managedObjectContext)
        shoppingItem.name = name
        shoppingItem.market = market
        shoppingItem.isFavorite = isFavorite
        shoppingItem.price = price
        saveContext()
    }
    
    func delete(shoppingItem: ShoppingItem) {
        managedObjectContext.delete(shoppingItem)
        saveContext()
    }
    
}
