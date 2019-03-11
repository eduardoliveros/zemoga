//
//  User+CoreDataClass.swift
//  
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//
//

import Foundation
import CoreData
import UIKit

@objc(User)
public class User: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    static func userWithInfo(_ info: [AnyHashable: Any]) -> User? {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        guard let id = info["id"] as? Int else {
            return nil
        }
        request.predicate = NSPredicate(format: "id == \(id)")
        var userValue: User?
        if let userT = (try? context.fetch(request))?.first as? User {
            userValue = userT
        } else if let userT = NSEntityDescription.insertNewObject(forEntityName: DataBaseEntities.user.entity, into: context) as? User {
            userValue = userT
            userValue!.id = info["id"] as? Int16 ?? 0
        }
        
        userValue?.email = info["email"] as? String ?? ""
        userValue?.name = info["name"] as? String ?? ""
        userValue?.phone = info["phone"] as? String ?? ""
        userValue?.website = info["website"] as? String ?? ""
        
        return userValue
    }
}
