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

class ViewProvider {

    static let shared = ViewProvider()

    /// Compose a MVVM module for a given component.
    /// model, view, viewModel

    func mvvm(for module: MVVMComposer) -> UINavigationController? {
        var navigator: UINavigationController?
        var vc: UIViewController?

        switch module {
        case .repositoryList:
            vc = R.storyboard.repository.repositoryListViewController()
            (vc as? RepositoryListViewController)?.viewModel = RepositoryListViewModel()
            navigator = R.storyboard.repository.instantiateInitialViewController()!
        case .repositoryDetail:
            break
        case .userDetail:
            break
        }

        if let vc = vc {
            navigator?.setViewControllers([vc], animated: false)
        }

        return navigator
        
    }
}

