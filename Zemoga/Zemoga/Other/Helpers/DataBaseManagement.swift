//
//  DataBaseManagement.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

enum DataBaseEntities {
    case user, comment, post
    
    var entity: String {
        switch self {
        case .user:
            return "User"
        case .comment:
            return "Comment"
        case .post:
            return "Post"
        }
    }
}
