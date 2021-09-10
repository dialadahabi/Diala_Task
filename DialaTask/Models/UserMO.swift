//
//  UserMO.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import Foundation
import CoreData

protocol DomainModel {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}

@objc(UserMO)
public class UserMO: NSManagedObject {

}

extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var age: String?

}

extension UserMO: DomainModel {
    func toDomainModel() -> User {
        return User(email: email,
                    password: password,
                    age: age)
    }
}
