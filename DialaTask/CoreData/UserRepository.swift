//
//  UserRepository.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import CoreData

protocol UserRepositoryInterface {
    func getUser(predicate: NSPredicate?) -> Result<[User], Error>
    func create(user: User) -> Result<Bool, Error>
}


class UserRepository {

    private let repository: CoreDataRepository<UserMO>

    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<UserMO>(managedObjectContext: context)
    }
}

extension UserRepository: UserRepositoryInterface {
    
    @discardableResult func getUser(predicate: NSPredicate?) -> Result<[User], Error> {
        let result = repository.getUser(predicate: predicate)
        switch result {
        case .success(let userMO):
            let users = userMO.map { userMO -> User in
                return userMO.toDomainModel()
            }
            
            return .success(users)
        case .failure(let error):
            return .failure(error)
        }
    }

    @discardableResult func create(user: User) -> Result<Bool, Error> {
        let result = repository.create()
        switch result {
        case .success(let userMO):
            userMO.email = user.email
            userMO.password = user.password
            userMO.age = user.age
            return .success(true)

        case .failure(let error):
            return .failure(error)
        }
    }

    
}
