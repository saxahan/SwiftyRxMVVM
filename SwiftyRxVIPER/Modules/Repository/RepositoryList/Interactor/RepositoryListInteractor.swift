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

    func searchRepository(query: String, page: Int, limit: Int) {
        presenter?.searchRepositorySuccess(repositoryList: API.repositoryProvider.rx.request(.searchRepositories(term: query, page: page, limit: limit))
            .asObservable()
            .map(RepositoryList.self))
    }
}
