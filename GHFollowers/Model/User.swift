//
//  User.swift
//  GHFollowers
//
//  Created by Aya on 10/10/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import Foundation
struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
   
 
    
}
