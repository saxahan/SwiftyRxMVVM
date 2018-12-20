//
//  API.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

final class API {
    static let userProvider: MoyaProvider<UserService> = {
        return MoyaProvider<UserService>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : [])
    }()

    static let repositoryProvider: MoyaProvider<RepositoryService> = {
        return MoyaProvider<RepositoryService>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : [])
    }()
}
