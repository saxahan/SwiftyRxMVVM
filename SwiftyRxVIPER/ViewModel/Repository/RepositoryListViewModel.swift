//
//  RepositoryListViewModel.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

class RepositoryListViewModel: SearchPaginationViewModel<Repository, RepositoryService> {

    override func loadData(query: String, page: Int, limit: Int) -> Observable<[Repository]> {
        self.page = page

        return Observable<[Repository]>.create { [unowned self] observer in
            self.provider.request(.searchRepositories(term: query, page: page, limit: limit))
                .subscribe { e in
                    switch e {
                    case .success(let result):
                        if result.statusCode == 403 {
                            observer.onError(ServiceError.limitReached)
                            return
                        }

                        self.totalCount = try! result.map(Int.self, atKeyPath: "total_count")
                        observer.onNext(try! result.map([Repository].self, atKeyPath: "items"))
                    case .error(let error):
                        observer.onError(error)
                    }
            }
        }
    }

    /// Open repository detail page

    func didSelectRow(_ repository: Repository) -> UIViewController? {
        return MVVMComposer.createInstance(for: .repositoryDetailView(repository: repository))
    }

    /// Open user detail page on avatar tapped

    func didTappedAvatar(_ user: User) -> UIViewController? {
        return MVVMComposer.createInstance(for: .userDetailView(user: user))
    }
}
