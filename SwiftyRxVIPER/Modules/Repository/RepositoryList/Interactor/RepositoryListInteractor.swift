//
//  RepositoryListInteractor.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryListInteractor: PresenterToInteractorRepositoryListProtocol {

    var presenter: InteractorToPresenterRepositoryListProtocol?
    let provider = API.repositoryProvider.rx
    let disposeBag = DisposeBag()

    func searchRepository(query: String, page: Int, limit: Int) {
        provider.request(.searchRepositories(term: query, page: page, limit: limit))
            .map(RepositoryList.self)
            .retry(3)
            .subscribe { [unowned self] event in
                switch event {
                case .success(let response):
                    self.presenter?.searchRepositorySuccess(repositoryList: response)
                case .error(let err):
                    self.presenter?.searchRepositoryFailed(error: err)
                }
            }.disposed(by: disposeBag)
    }
}
