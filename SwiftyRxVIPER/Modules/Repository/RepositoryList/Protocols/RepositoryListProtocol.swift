//
//  RepositoryListProtocol.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewToPresenterRepositoryListProtocol {
    var view: PresenterToViewRepositoryListProtocol? { get set }
    var interactor: PresenterToInteractorRepositoryListProtocol? { get set }
    var router: PresenterToRouterRepositoryListProtocol? { get set }
    func startSearchingRepositories(query: String, page: Int, limit: Int, isPagination: Bool)
}

protocol PresenterToViewRepositoryListProtocol {
    func onSearchRepositorySuccess(repositoryList: RepositoryList, isPagination: Bool)
    func onSearchRepositoryFailed(error: Error)
}

protocol PresenterToInteractorRepositoryListProtocol {
    var presenter: InteractorToPresenterRepositoryListProtocol? { get set }
    func searchRepository(query: String, page: Int, limit: Int, isPagination: Bool)
}

protocol PresenterToRouterRepositoryListProtocol {
    func createRepositoryListModule() -> UINavigationController
}

protocol InteractorToPresenterRepositoryListProtocol {
    func searchRepositorySuccess(repositoryList: RepositoryList, isPagination: Bool)
    func searchRepositoryFailed(error: Error)
}
