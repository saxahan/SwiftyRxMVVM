//
//  RepositoryService.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

enum RepositoryService {
    case getRepository(id: Int)
    case searchRepositories(term: String, page: Int, limit: Int)
}

extension RepositoryService: TargetType {

    var baseURL: URL {
        switch self {
        case .searchRepositories:
            return AppConfig.baseURL.appendingPathComponent("search").appendingPathComponent("repositories")

        default:
            return AppConfig.baseURL.appendingPathComponent("repositories")
        }
    }

    var path: String {
        switch self {
        case .getRepository(let id):
            return "\(id)"

        default:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .searchRepositories(let term, let page, let limit):
            return .requestParameters(parameters: ["q": term, "page": page, "per_page": limit], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return AppConfig.baseHeaders
    }
}
