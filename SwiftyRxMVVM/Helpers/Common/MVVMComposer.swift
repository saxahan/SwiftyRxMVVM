//
//  MVVMComposer.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import UIKit

enum MVVMComposite {
    case userDetailView(user: User)
    case repositoryDetailView(repository: Repository)
    case repositoryListView
}

class MVVMComposer {

    /// Compose a MVVM module for a given composite.
    /// model, view, viewModel

    static func createInstance(for composite: MVVMComposite) -> UIViewController? {
        switch composite {
        case .userDetailView(let user):
            guard let vc = R.storyboard.user.userDetailViewController() else { return nil }
            vc.viewModel = UserDetailViewModel(user)
            return vc
        case .repositoryDetailView(let repository):
            guard let vc = R.storyboard.repository.repositoryDetailViewController() else { return nil }
            vc.viewModel = RepositoryDetailViewModel(repository)
            return vc
        case .repositoryListView:
            guard let vc = R.storyboard.repository.repositoryListViewController() else { return nil }
            vc.viewModel = RepositoryListViewModel()

            let navigator = R.storyboard.repository.instantiateInitialViewController()
            navigator?.setViewControllers([vc], animated: false)
            return navigator
        }
    }
}
