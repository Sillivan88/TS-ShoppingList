//
//  Persistence.swift
//  TS ShoppingList
//
//  Created by Trainer on 21.09.20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = ShoppingItem(context: viewContext)
            newItem.name = "Testprodukt"
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static let testShoppingItem: ShoppingItem = {
        let testShoppingItem = ShoppingItem(context: PersistenceController.preview.container.viewContext)
        testShoppingItem.name = "Testprodukt"
        return testShoppingItem
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TS_ShoppingList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
