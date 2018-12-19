//
//  UserService.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case getUser(id: Int)
    case getUserBy(username: String)
    case getUserRepos(username: String)
}

extension UserService: TargetType {

    var baseURL: URL {
        return AppConfig.baseURL.appendingPathComponent("users")
    }

    var path: String {
        switch self {
        case .getUser(let id):
            return "\(id)"
        case .getUserBy(let username):
            return "\(username)"
        case .getUserRepos(let username):
            return "\(username)/repos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return AppConfig.baseHeaders
    }
}
