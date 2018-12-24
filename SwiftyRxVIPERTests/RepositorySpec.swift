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

    override func spec() {
        var provider: MoyaProvider<RepositoryService>!
        var repository: Repository!
        var repositoryList: [Repository]!

        beforeEach {
            // We should use sampleData.
            // However; if we want to do async, we can use OHHTTPStubs for demonstrating, or waitUntil might be helpful.
            provider = API.repositoryProvider
        }

        func parseItems(_ data: Response) -> [Repository]? {
            return try? data.map([Repository].self, atKeyPath: "items")
        }

        it("shouldn't has empty items array") {
            let target = RepositoryService.searchRepositories

            provider.request(target("swift", 1, 20)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    repositoryList = parseItems(response)
                }

                expect(repositoryList).notTo(beEmpty())
            }
        }

        it("should has nil because no given term") {
            let target = RepositoryService.searchRepositories

            provider.request(target("", 1, 20)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    repositoryList = parseItems(response)
                }

                expect(repositoryList).to(beNil())
            }
        }

        it("should get repository detail") {
            let target = RepositoryService.getRepository

            provider.request(target(5)) { result in
                switch result {
                case .failure(let error):
                    debugPrint(error.localizedDescription)

                case .success(let response):
                    repository = try? response.map(Repository.self)
                }

                expect(repository).notTo(beNil())
            }
        }
    }
}
