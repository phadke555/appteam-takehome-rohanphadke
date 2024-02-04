//
//  SingleResponse.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import Foundation

struct CommentsResponse: Codable {
    var comments: [Comment]
}

struct Comment: Codable {
    var id: Int
    var body: String
    var postId: Int
    var user: User
}

struct User: Codable {
    var id: Int
    var username: String
}
