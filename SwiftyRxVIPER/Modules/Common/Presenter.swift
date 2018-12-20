//
//  Presenter.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

class Presenter<T> {
    typealias View = T
    private var disposeBag = DisposeBag()
    private var view: View?
    private var subPresenters: [Presenter<T>] = []

    func attachPresenter(_ presenter: Presenter<T>) {
        subPresenters.append(presenter)
    }

    func attachView(_ view: View) {
        assert(self.view == nil)
        self.view = view
        subPresenters.forEach { $0.attachView(view) }
    }

    func detachView() {
        subPresenters.forEach { $0.detachView() }
        view = nil
        disposeBag = DisposeBag()
    }

    func disposeOnViewDetach(_ disposable: Disposable) {
        subPresenters.forEach { $0.disposeOnViewDetach(disposable) }
        disposeBag.insert(disposable)
    }
}
