//
//  MarketManager.swift
//  TS ShoppingList
//
//  Created by Trainer on 19.11.20.
//

import Foundation

class MarketManager: PersistenceManager {
    
    func delete(market: Market) {
        managedObjectContext.delete(market)
        saveContext()
    }
    
}
