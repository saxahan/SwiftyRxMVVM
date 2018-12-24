//
//  BindableViewController.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

protocol BindableProtocols: class {
    func bindViews()
    func isLoading(for view: UIView) -> AnyObserver<Bool>?
    func onError() -> AnyObserver<Error>?
}

class BindableViewController<T>: UIViewController, BindableProtocols, Modelable {

    typealias ViewModel = T
    var viewModel: T!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
    }

    func bindViews() { }

    func isLoading(for view: UIView) -> AnyObserver<Bool>? {
        return nil
    }

    func onError() -> AnyObserver<Error>? {
        return nil
    }
}
