//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var body: String?
    @NSManaged public var read: Bool
    @NSManaged public var id: Int16
    @NSManaged public var userId: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isActive: Bool
}
