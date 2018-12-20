//
//  RepositoryListRouter.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import UIKit

enum RepositoryListRoute {
    case detail(Repository)
}

extension RepositoryListRoute: Equatable {}

func ==(lhs: RepositoryListRoute, rhs: RepositoryListRoute) -> Bool {
    switch (lhs, rhs) {
    case ( let .detail(a), let .detail(b)):
        return a == b
    }

}

protocol RepositoryListRouterInput {
    func go(to route : RepositoryListRoute)
}

struct RepositoryListRouter : RepoListRouterInput {

    private weak var controller : RepoListController?

    static func instantiateController() -> RepoListController {
        let controller = RepoListController(nibName: "RepoListController", bundle: nil)

        let interactor = RepoListInteractor()
        let router = RepoListRouter(controller : controller)
        let presenter = RepoListPresenter(router: router, interactor: interactor, viewController: controller)
        controller.presenter = presenter

        return controller
    }

    func go(to route : RepoListRoute) {
        switch route {
        case .details(let repository):
            let detailsController = DetailsRouter.instantiateController(forRepository: repository)
            self.controller?.navigationController?.pushViewController(detailsController, animated: true)
            break
        }
    }


}
