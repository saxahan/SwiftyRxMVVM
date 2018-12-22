//
//  Repository.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/// We're only using GET methods, so that we only need Decodable for mapping json responses to our model objects.

struct Repository: Decodable {
    var id: Int
    var name: String
    var fullName: String?
    var forksCount: Int = 0
    var openIssuesCount: Int = 0
    var hasWiki: Bool = false
    var hasIssues: Bool = false
    var hasPages: Bool = false
    var owner: User
    // etc...

    enum CodingKeys: String, CodingKey {
        case id, name, fullName = "full_name", forksCount = "forks_count", openIssuesCount = "open_issues_count", hasWiki = "has_wiki", hasIssues = "has_issues", hasPages = "has_pages", owner
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        self.forksCount = try container.decode(Int.self, forKey: .forksCount)
        self.openIssuesCount = try container.decode(Int.self, forKey: .openIssuesCount)
        self.hasWiki = try container.decode(Bool.self, forKey: .hasWiki)
        self.hasIssues = try container.decode(Bool.self, forKey: .hasIssues)
        self.hasPages = try container.decode(Bool.self, forKey: .hasPages)
        self.owner = try container.decode(User.self, forKey: .owner)
    }
}
