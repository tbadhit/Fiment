//
//  Persistence.swift
//  FimentApp
//
//  Created by Tubagus Adhitya Permana on 11/04/22.
//

import CoreData

struct PersistenceController {
    static let shared =  PersistenceController()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        // Name of container "CoreData" *sesuai dgn nama file Data Modelnya
        container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: {(_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
