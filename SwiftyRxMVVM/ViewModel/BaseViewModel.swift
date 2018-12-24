//
//  BaseViewModel.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BaseViewModel<T, S: Definable> {

    let refreshTrigger = PublishSubject<Void>()
    let loading = Variable<Bool>(false)
    let error = PublishSubject<Error>()
    let disposeBag = DisposeBag()
    internal var provider: Reactive<MoyaProvider<S>>

    init() {
        provider = MoyaProvider<S>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : []).rx
    }
}
