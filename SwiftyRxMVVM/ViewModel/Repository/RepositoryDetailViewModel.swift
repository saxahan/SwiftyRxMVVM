//
//  RepositoryDetailViewModel.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 24.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import RxSwift

class RepositoryDetailViewModel: BaseViewModel<Repository, RepositoryService> {

    internal var repository: Repository
    var repositoryTrigger: Variable<Repository>!
    var userTrigger: Variable<User>!

    required init(_ repository: Repository) {
        self.repository = repository
        super.init()

        repositoryTrigger = Variable<Repository>(repository)
        userTrigger = Variable<User>(repository.owner)
    }

    func didTappedAvatar() -> UIViewController? {
        return MVVMComposer.createInstance(for: .userDetailView(user: repository.owner))
    }
}
