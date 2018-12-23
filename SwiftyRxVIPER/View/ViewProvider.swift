//
//  ViewProvider.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import UIKit

enum MVVMComposer {
    case repositoryList, repositoryDetail, userDetail
}

enum ViewItem {
    case userDetailView(user: User)
    case repositoryDetailView(repository: Repository)
}

class ViewProvider {

    static let shared = ViewProvider()

    /// Compose a MVVM module for a given component.
    /// model, view, viewModel

    func mvvm(for module: MVVMComposer, viewItem: ViewItem? = nil) -> UIViewController? {
        var navigator: UINavigationController?
        var vc: UIViewController?

        switch module {
        case .repositoryList:
            vc = R.storyboard.repository.repositoryListViewController()
            (vc as? RepositoryListViewController)?.viewModel = RepositoryListViewModel()
            navigator = R.storyboard.repository.instantiateInitialViewController()!
        case .repositoryDetail:
            if let viewItem = viewItem {
                switch viewItem {
                case .repositoryDetailView(let repository):
                    // TODO: initialize repository detail page
                    break
                default: break
                }
            }
            break
        case .userDetail:
            if let viewItem = viewItem {
                switch viewItem {
                case .userDetailView(let user):
                    vc = R.storyboard.user.userDetailViewController()
                    (vc as? UserDetailViewController)?.viewModel = UserDetailViewModel(user)
                    return vc

                default: break
                }
            }
        }

        if let vc = vc {
            navigator?.setViewControllers([vc], animated: false)
        }

        return navigator
        
    }
}
