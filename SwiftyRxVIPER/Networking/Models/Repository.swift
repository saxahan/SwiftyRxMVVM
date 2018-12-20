//
//  Repository.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/**
 * We're only using GET methods, so that we only need Decodable for mapping json responses to our model objects.
 */

struct Repository: Decodable {
    var id: Int
    var name: String?
    var fullName: String?
    var forksCount: Int = 0
    var openIssuesCount: Int = 0
    var hasWiki: Bool = false
    var hasIssues: Bool = false
    var hasPages: Bool = false
    var owner: User?
    // etc...

    enum CodingKeys: String, CodingKey {
        case id, name, fullName = "full_name", forksCount = "forks_count", openIssuesCount = "open_issues_count", hasWiki = "has_wiki", hasIssues = "has_issues", hasPages = "has_pages"
    }
}
