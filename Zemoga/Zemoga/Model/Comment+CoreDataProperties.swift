//
//  Comment+CoreDataProperties.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var postId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var body: String?
}
