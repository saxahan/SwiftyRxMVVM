//
//  UserService.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

enum UserService: Definable {
    case getUser(id: Int)
    case getUserBy(username: String)
    case getUserRepos(username: String, page: Int, limit: Int)
}

extension UserService {

    var baseURL: URL {
        return AppConfig.baseURL.appendingPathComponent("users")
    }

    var path: String {
        switch self {
        case .getUser(let id):
            return "\(id)"
        case .getUserBy(let username):
            return "\(username)"
        case .getUserRepos(let username, _, _):
            return "\(username)/repos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .getUser, .getUserBy:
            return try! Data(resource: R.file.getUser200ResJson)
        case .getUserRepos(let username, _, _):
            if username.isEmpty {
                return Data()
            }
            
            return try! Data(resource: R.file.getUserRepos200ResJson)
        }
    }

    var task: Task {
        switch self {
        case .getUserRepos(_, let page, let limit):
            return .requestParameters(parameters: ["page": page, "per_page": limit], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return AppConfig.baseHeaders
    }
}
