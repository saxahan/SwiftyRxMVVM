//
//  RepositoryListInteractor.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositoryListInteractorInput {
    func searchRepositories(for query: String, page: Int, limit: Int, callback: @escaping (RepositoryList?) -> Void)
}

struct RepositoryListInteractor: RepositoryListInteractorInput {
    func searchRepositories(for query: String, page: Int, limit: Int, callback: @escaping (RepositoryList?) -> Void) {
        API.repositoryProvider.rx.request(.searchRepositories(term: query, page: page, limit: limit)).subscribe { event in
            switch event {
            case let .success(response):
                let repositoryList = try? response.map(RepositoryList.self)
                callback(repositoryList)
            case let .error(error):
                debugPrint(error)
                callback(nil)
            }
        }
    }


}
