//
//  SingleResponse.swift
//  takehome
//
//  Created by Rohan Phadke on 2/2/24.
//

import Foundation

struct CommentsResponse: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let id: Int
    let body: String
    let postId: Int
    let user: User
}

struct User: Codable {
    let id: Int
    let username: String
}
