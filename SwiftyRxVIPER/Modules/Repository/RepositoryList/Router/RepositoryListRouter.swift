//
//  RepositoryListRouter.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import UIKit

class RepositoryListRouter: PresenterToRouterRepositoryListProtocol {

    private var repositorySearchViewController: RepositorySearchViewController!

    private func initViewController() {
        repositorySearchViewController = R.storyboard.repository.repositorySearchViewController()
    }

    func createRepositoryListModule() -> UINavigationController {
        initViewController()
        let presenter = RepositoryListPresenter()
        let interactor = RepositoryListInteractor()

        presenter.router = self
        presenter.view = repositorySearchViewController
        presenter.interactor = interactor
        presenter.interactor?.presenter = presenter
        self.repositorySearchViewController?.presenter = presenter

        let navigator = R.storyboard.repository.instantiateInitialViewController()!
        navigator.setViewControllers([self.repositorySearchViewController], animated: false)

        return navigator
    }
}
