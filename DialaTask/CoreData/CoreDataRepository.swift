//
//  CoreDataRepository.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import CoreData

enum CoreDataError: Error {
    case invalidManagedObjectType
}

class CoreDataRepository<T: NSManagedObject>: Repository {
    typealias Entity = T

    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func getUser(predicate: NSPredicate?) -> Result<[Entity], Error> {
        
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }

    func create() -> Result<Entity, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        return .success(managedObject)
    }
    
}
