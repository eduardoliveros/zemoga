//
//  Post+CoreDataClass.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import UIKit
import CoreData

@objc(Post)
public class Post: NSManagedObject {
    static func postWithInfo(_ info: [AnyHashable: Any], reload: Bool = false) -> Post? {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Post")
        guard let id = info["id"] as? Int else {
            return nil
        }
        request.predicate = NSPredicate(format: "id == \(id)")
        var userValue: Post?
        if let userT = (try? context.fetch(request))?.first as? Post {
            userValue = userT
        } else if let userT = NSEntityDescription.insertNewObject(forEntityName: DataBaseEntities.post.entity, into: context) as? Post {
            userValue = userT
            userValue!.id = info["id"] as? Int16 ?? 0
        }
        
        userValue?.isActive = reload
        userValue?.body = info["body"] as? String ?? ""
        userValue?.userId = info["userId"] as? Int16 ?? 0
        
        return userValue
    }
    
    static func getFavorites() -> [Post]? {
        
        let appDel: AppDelegate = ((UIApplication.shared.delegate) as! AppDelegate)
        let request: NSFetchRequest<NSFetchRequestResult>  = NSFetchRequest (entityName: "Post")
        request.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "isFavorite == true && isActive == true")
        do {
            let results = try appDel.managedObjectContext.fetch(request)
            if results.count > 0 {
                return results as? [Post]
            }
        } catch {
            print(error)
        }
        return nil
    }
}
