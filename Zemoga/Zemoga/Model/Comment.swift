//
//  Comment+CoreDataClass.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import CoreData
import UIKit

@objc(Comment)
public class Comment: NSManagedObject {
    static func commentWithInfo(_ info: [AnyHashable: Any]) -> Comment? {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Comment")
        guard let id = info["id"] as? Int else {
            return nil
        }
        request.predicate = NSPredicate(format: "id == \(id)")
        var userValue: Comment?
        if let userT = (try? context.fetch(request))?.first as? Comment {
            userValue = userT
        } else if let userT = NSEntityDescription.insertNewObject(forEntityName: DataBaseEntities.comment.entity, into: context) as? Comment {
            userValue = userT
            userValue!.id = info["id"] as? Int16 ?? 0
        }
        
        userValue?.body = info["body"] as? String ?? ""
        userValue?.postId = info["postId"] as? Int16 ?? 0
        
        return userValue
    }
}
