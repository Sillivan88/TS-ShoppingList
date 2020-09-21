//
//  TS_ShoppingListApp.swift
//  TS ShoppingList
//
//  Created by Trainer on 21.09.20.
//

import SwiftUI

@main
struct TS_ShoppingListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
