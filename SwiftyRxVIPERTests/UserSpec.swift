//
//  UserSpec.swift
//  SwiftyRxVIPERTests
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya
import Nimble
import Quick

@testable import SwiftyRxVIPER

class UserSpec: QuickSpec {
    
    override func spec() {
        var provider: MoyaProvider<UserService>!
        var user: User!
        var userRepos: [Repository]!

        beforeEach {
            // We should use sampleData.
            // However; if we want to do async, we can use OHHTTPStubs for demonstrating, or waitUntil might be helpful.
            provider = API.userProvider
        }

        it("should get user detail by username") {
            let target = UserService.getUserBy

            provider.request(target("saxahan")) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    user = try? response.map(User.self)
                }

                expect(user).notTo(beNil())
            }
        }

        it("should has user repositories by username for a given page") {
            let target = UserService.getUserRepos

            provider.request(target("saxahan", 1, 20)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    userRepos = try? response.map([Repository].self)
                }

                expect(userRepos).notTo(beNil())
            }
        }

        it("shouldn't has repos") {
            let target = UserService.getUserRepos

            provider.request(target("saxahan", 1, 20)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    userRepos = try? response.map([Repository].self)
                }

                expect(userRepos).to(beNil())
            }
        }
    }
}
