//
//  BaseViewModel.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class BaseViewModel<T, S: Definable> {

    let disposeBag = DisposeBag()
    internal var provider: Reactive<MoyaProvider<S>>

    init() {
        provider = MoyaProvider<S>(plugins: AppConfig.isDebug ? [NetworkLoggerPlugin(verbose: true)] : []).rx
    }
}
