//
//  RepositoryList.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/// Mapping paginated list response

struct RepositoryList: Decodable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count", incompleteResults = "incomplete_results", items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(Int.self, forKey: .totalCount)
        self.incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        self.items = try container.decode([Repository].self, forKey: .items)
    }
}
