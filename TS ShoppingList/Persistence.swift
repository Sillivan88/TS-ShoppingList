//
//  Persistence.swift
//  TS ShoppingList
//
//  Created by Trainer on 21.09.20.
//

import CoreData

class PersistenceManager: ObservableObject {
    var managedObjectContext: NSManagedObjectContext
    
    init(usePreview: Bool = false) {
        self.managedObjectContext = usePreview ? PersistenceController.preview.managedObjectContext : PersistenceController.shared.managedObjectContext
    }
    
    func saveContext() {
        try? managedObjectContext.save()
    }
}

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
    
    var managedObjectContext: NSManagedObjectContext {
        container.viewContext
    }

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
    
    func saveContext() {
        try? managedObjectContext.save()
    }
}
