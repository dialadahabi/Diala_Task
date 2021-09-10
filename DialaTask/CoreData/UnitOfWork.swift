//
//  UnitOfWork.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import CoreData

class UnitOfWork {

    private let context: NSManagedObjectContext

    let userRepository: UserRepository

    init(context: NSManagedObjectContext) {
        self.context = context
        self.userRepository = UserRepository(context: context)
    }

    @discardableResult func saveChanges() -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        } catch {
            context.rollback()
            return .failure(error)
        }
    }
}
