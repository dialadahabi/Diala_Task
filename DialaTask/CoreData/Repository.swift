//
//  Repository.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import CoreData

protocol Repository {
    
    associatedtype Entity

    func getUser(predicate: NSPredicate?) -> Result<[Entity], Error>

    func create() -> Result<Entity, Error>
    
}
