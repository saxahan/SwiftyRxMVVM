//
//  User.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/**
 * We're only using GET methods, so that we only need Decodable for mapping json responses to our model objects.
 */

struct User: Decodable {
    var id: Int
    var username: String?
    var avatarUrl: String?
    var email: String?
    var location: String?
    var blog: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case id, username = "login", avatarUrl = "avatar_url", email, location, blog, url
    }
}
