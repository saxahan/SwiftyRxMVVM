//
//  API.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

final class API {

    // * For testing purposes, providers are defined as statics
    // * Not recommended
    // ** We should keep local variables in each view models for provider instead.

    static let userProvider: MoyaProvider<UserService> = {
        return MoyaProvider<UserService>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : [])
    }()

    static let repositoryProvider: MoyaProvider<RepositoryService> = {
        return MoyaProvider<RepositoryService>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : [])
    }()
}
