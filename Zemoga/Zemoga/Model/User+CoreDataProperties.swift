//
//  User+CoreDataProperties.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var website: String?
    @NSManaged public var id: Int16
    @NSManaged public var phone: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?

}
