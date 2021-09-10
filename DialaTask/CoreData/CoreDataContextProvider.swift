//
//  CoreDataContextProvider.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import CoreData

class CoreDataContextProvider {
    
    static let shared = CoreDataContextProvider()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer

    init(completionClosure: ((Error?) -> Void)? = nil) {
        
        persistentContainer = NSPersistentContainer(name: "User")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")

            }
            completionClosure?(error)
        }
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
