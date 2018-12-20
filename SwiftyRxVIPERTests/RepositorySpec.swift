//
//  RepositorySpec.swift
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

class RepositorySpec: QuickSpec {

    let searchTimeout: TimeInterval = 20

    override func spec() {
        var provider: MoyaProvider<RepositoryService>!
        var repositoryList: RepositoryList!

        beforeEach {
            // If we want to use sync testing, we should use sampleData of Maya
            // for instance -> MoyaProvider<RepositoryService>(stubClosure: MoyaProvider.immediatelyStub)
            // But I want to search on real data on github.
            provider = MoyaProvider<RepositoryService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        }

        // Async real data
        it("should search through repositories and should return paginated repository list") {
            let target = RepositoryService.searchRepositories

            waitUntil(timeout: self.searchTimeout, action: { done in
                provider.request(target("swift", 1, 20)) { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error.localizedDescription)

                    case .success(let response):
                        repositoryList = try? response.map(RepositoryList.self)
                        debugPrint(repositoryList)
                    }

                    expect(repositoryList).notTo(beNil())
                }
            })
        }


        /* Sync Sample data test
        it("should search through repositories and should return paginated repository list") {
            provider = MoyaProvider<RepositoryService>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(verbose: true)])
            let target = RepositoryService.searchRepositories

            provider.request(target("swift", 1, 20)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    repositoryList = try? response.map(RepositoryList.self)
                    debugPrint(repositoryList)
                }

                expect(repositoryList).notTo(beNil())
            }
        }
        */

    }
}
