//
//  API.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Moya

/**
 * Another way is to define pre defined macros in project settings
 * For examples: STAGING, UAT etc.
 * Reading from infoDictionary is automatically bind "API_BASE_URL" string variable to ${API_BASE_URL} according to macros.
 * However; I like to use another approach which Moya offers it us.
 -----

 final class API {
     static var baseURL: URL!

     static func configure() {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"), let apiConfig = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> else {
           fatalError("No defined Api plist file!")
        }

        baseURL = URL(string: infoDict["API_BASE_URL"] as! String)
     }
 }
 */

final class API: APIType {
    typealias Environment = DevelopmentEnv
    var Environment: EnvironmentType

    static let shared = API()
    var isDevelopment: Bool = true
    var isStaging: Bool = false
    var isProduction: Bool = false

    var repositoryProvider: MoyaProvider<RepositoryService<Environment>>?
    var userProvider: MoyaProvider<UserService<Environment>>?

    init() {
        #if STAGING
            isStaging = true
            self.Environment = StagingEnv()
        #endif

        #if PRODUCTION
            isProduction = true
        #endif

        repositoryProvider = MoyaProvider<RepositoryService<Environment>>()
        userProvider = MoyaProvider<UserService<Environment>>()
    }
}
