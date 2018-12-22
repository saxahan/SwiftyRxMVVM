//
//  RepositoryListPresenter.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

class RepositoryListPresenter: ViewToPresenterRepositoryListProtocol {
    var view: PresenterToViewRepositoryListProtocol?
    var interactor: PresenterToInteractorRepositoryListProtocol?
    var router: PresenterToRouterRepositoryListProtocol?

    func startSearchingRepositories(query: String, page: Int, limit: Int, isPagination: Bool) {
        interactor?.searchRepository(query: query, page: page, limit: limit, isPagination: isPagination)
    }
}

extension RepositoryListPresenter: InteractorToPresenterRepositoryListProtocol {
    func searchRepositorySuccess(repositoryList: RepositoryList, isPagination: Bool) {
        view?.onSearchRepositorySuccess(repositoryList: repositoryList, isPagination: isPagination)
    }

    func searchRepositoryFailed(error: Error) {
        view?.onSearchRepositoryFailed(error: error)
    }
}
