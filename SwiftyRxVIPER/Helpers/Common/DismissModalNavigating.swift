//
//  DismissModalNavigating.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

protocol DismissModalNavigating {
    func dismiss() -> Completable
}

extension Navigator where Self: DismissModalNavigating {
    func dismiss() -> Completable {
        return self.dismiss(with: ModalNavigation(), animated: true)
    }
}
