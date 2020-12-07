//
//  MarketManager.swift
//  TS ShoppingList
//
//  Created by Trainer on 19.11.20.
//

import Foundation

class MarketManager {
    
    static let shared = MarketManager()
    
    private init() {}
    
    func delete(market: Market) {
        PersistenceController.shared.managedObjectContext.delete(market)
        PersistenceController.shared.saveContext()
    }
    
}
