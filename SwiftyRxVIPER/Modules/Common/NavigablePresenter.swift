//
//  NavigablePresenter.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

class NavigablePresenter<T, U>: Presenter<T> {
    typealias Navigator = U
    var navigator: Navigator?

    func attachNavigator(_ navigator: Navigator) {
        assert(self.navigator == nil)
        self.navigator = navigator
    }

    func detachNavigator() {
        self.navigator = nil
    }
}
