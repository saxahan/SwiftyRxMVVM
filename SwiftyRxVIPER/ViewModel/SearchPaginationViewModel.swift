//
//  SearchPaginationViewModel.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

class SearchPaginationViewModel<T, S: Definable>: BaseViewModel<T, S> {

    let refreshTrigger = PublishSubject<Void>()
    let loadNextPageTrigger = PublishSubject<Void>()
    var searchTrigger = PublishSubject<String>()
    let loading = Variable<Bool>(false)
    let query = Variable<String>("")
    let elements = Variable<[T]>([])
    let error = PublishSubject<Swift.Error>()
    internal var totalCount: Int = 0
    var page: Int = 0
    var allPageLoaded: Bool = false

    override init() {
        super.init()
        
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
                if loading || self.allPageLoaded {
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

        searchTrigger
            .asObservable()
            .filterEmpty()
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] term -> Observable<[T]> in
                self.query.value = term
                self.page = 1
                self.loading.value = true
                return self.loadData(query: term, page: self.page)
            }
            .subscribe(onNext: { items in
                self.loading.value = false
                self.elements.value = items
                self.allPageLoaded = self.totalCount == items.count
            }).disposed(by: disposeBag)

        let request = Observable
            .of(refreshRequest, nextPageRequest)
            .merge()
            .share(replay: 1)

        let response = request.flatMap { [unowned self] page -> Observable<[T]> in
            self.loadData(query: self.query.value, page: page)
                .do(onError: { error in
                    self.error.onNext(error)
                }).catchError({ _ -> Observable<[T]> in
                    Observable.empty()
                })
            }.share(replay: 1)

        Observable
            .combineLatest(request, response, elements.asObservable()) { [unowned self] _, response, elements in
                let newElements = self.page == 0 ? response : elements + response
                self.allPageLoaded = self.totalCount == newElements.count
                return newElements
            }
            .sample(response)
            .bind(to: elements)
            .disposed(by: disposeBag)

        Observable
            .of(request.map{_ in true},
                response.map { $0.isEmpty },
                error.map { _ in false })
            .merge()
            .bind(to: loading)
            .disposed(by: disposeBag)
    }

    func loadData(query: String, page: Int, limit: Int = 20) -> Observable<[T]> {
        return Observable.empty()
    }
}
