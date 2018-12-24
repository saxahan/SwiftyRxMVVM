//
//  UserDetailViewModel.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional
import RxDataSources

/**
 * This view model should extend `SearchPaginationViewModel`; but I like to show different way because no searching needs.
 * There can be created more generic class in order to handle such cases.
 * In this view model, which handles UserDetailViewController view class by observable variables & subjects.
 */

class UserDetailViewModel: BaseViewModel<User, UserService> {

    var user: User
    let repos = Variable<[Repository]>([])
    let sectionTrigger = PublishSubject<[MultipleSectionModel]>()
    var sections: [MultipleSectionModel]!
    var dataSource: RxTableViewSectionedReloadDataSource<MultipleSectionModel>!
    var page: Int = 1
    var totalCount: Int = 0
    var allPageLoaded: Bool = false
    let loadNextPageTrigger = PublishSubject<Void>()

    required init(_ user: User) {
        self.user = user
        super.init()

        // first init user section
        sections = [
            .UserSection(title: user.username!, items: [.UserSectionItem(user: user)])
        ]

        let refreshRequest = loading.asObservable()
            .sample(refreshTrigger)
            .flatMap { loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { observer in
                        observer.onNext(1)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
        }

        let nextPageRequest = loading.asObservable()
            .sample(loadNextPageTrigger)
            .flatMap { [unowned self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { [unowned self] observer in
                        self.page += 1
                        observer.onNext(self.page)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
        }

        let request = Observable
            .of(refreshRequest, nextPageRequest)
            .merge()
            .share(replay: 1)

        let response = request.flatMap { [unowned self] page -> Observable<[Repository]> in
            self.fetchUserRepos(page: page)
                .do(onError: { error in
                    self.error.onNext(error)
                }).catchError({ _ -> Observable<[Repository]> in
                    Observable.empty()
                })
            }.share(replay: 1)

        repos.asObservable()
            .subscribe({ [unowned self] (repositories) in
                if let elems = repositories.element, let sections = self.sections {
                    self.sectionTrigger.onNext(sections + [MultipleSectionModel.RepositorySection(title: "User Repositories", items: elems.map { .RepositorySectionItem(repository: $0) })])
                }

            })
            .disposed(by: disposeBag)

        Observable
            .combineLatest(request, response, repos.asObservable()) { [unowned self] _, response, elements in
                let newElements = self.page == 0 ? response : response + elements
                self.allPageLoaded = response.isEmpty

                if self.allPageLoaded {
                    self.loading.value = false
                }
                return newElements
            }
            .sample(response)
            .bind(to: repos)
            .disposed(by: disposeBag)

        Observable
            .of(request.map{_ in true},
                response.map { $0.isEmpty },
                error.map { _ in false })
            .merge()
            .bind(to: loading)
            .disposed(by: disposeBag)
    }

    func fetchUser(username: String) -> Observable<User> {
        return provider.request(.getUserBy(username: username))
            .map(User.self)
            .asObservable()
    }

    func fetchUserRepos(page: Int, limit: Int = 20) -> Observable<[Repository]> {
        self.page = page

        return Observable<[Repository]>.create { [unowned self] observer in
            self.provider.request(.getUserRepos(username: self.user.username!, page: page, limit: limit))
                .subscribe { e in
                    switch e {
                    case .success(let result):
                        if result.statusCode == 403 {
                            observer.onError(ServiceError.limitReached)
                            return
                        }

                        let items = try! result.map([Repository].self)
                        self.totalCount = items.count
                        self.allPageLoaded = items.isEmpty

                        if items.isEmpty {
                            self.loading.value = false
                            observer.onCompleted()
                        }
                        else {
                            observer.onNext(items)
                        }
                    case .error(let error):
                        observer.onError(error)
                    }
            }
        }
    }

    func didSelectRow(_ item: SectionItem) -> UIViewController? {
        if case let SectionItem.RepositorySectionItem(repository) = item  {
            return MVVMComposer.createInstance(for: .repositoryDetailView(repository: repository))
        }

        return nil
    }
}

enum MultipleSectionModel {
    case UserSection(title: String, items: [SectionItem])
    case RepositorySection(title: String, items: [SectionItem])
}

enum SectionItem {
    case UserSectionItem(user: User)
    case RepositorySectionItem(repository: Repository)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .UserSection(title: _, items: let items):
            return items.map {$0}
        case .RepositorySection(title: _, items: let items):
            return items.map {$0}
        }
    }

    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .UserSection(title: title, items: _):
            self = .UserSection(title: title, items: items)
        case let .RepositorySection(title, _):
            self = .RepositorySection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .UserSection(title: let title, items: _):
            return title
        case .RepositorySection(title: let title, items: _):
            return title
        }
    }
}
