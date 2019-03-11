//
//  GlobalVariables.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//
struct Urls {
    static let getPost = "https://jsonplaceholder.typicode.com/Posts"
    static let getUser = "https://jsonplaceholder.typicode.com/Users"
    static let getComment = "https://jsonplaceholder.typicode.com/Comments?postId="
}

struct Request {
    static let getPost = 3
    static let getUser = 1
    static let getComment = 2
}


struct ViewIdentifier {
    // ViewContrroller
    static let postViewController = "postViewController"
    static let detailViewController = "detailViewController"
    
    // Cell
    static let postTVC = "PostTVC"
    static let detailTVC = "DetailTVC"
    static let commentTVC = "CommentTVC"
    static let userTVC = "UserTVC"
}
