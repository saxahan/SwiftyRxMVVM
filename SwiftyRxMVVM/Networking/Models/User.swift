//
//  User.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/// We're only using GET methods, so that we only need Decodable for mapping json responses to our model objects.

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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

extension User {
    /// It's like a toString as variable :)

    var toString: String {
        let username = self.username ?? ""
        let email = self.email ?? ""
        let location = self.location ?? ""
        var detailText = "\(username)"

        if !email.isEmpty {
            detailText += "-\(email)"
        }

        if !location.isEmpty {
            detailText += "\n\(location)"
        }

        return detailText
    }
}
