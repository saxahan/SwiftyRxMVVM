//
//  UIScrollView+.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

extension UIScrollView {
    var rxReachedBottom: Observable<Void> {
        return rx.contentOffset
            .flatMap { [weak self] contentOffset -> Observable<Void> in
                guard let scrollView = self else {
                    return Observable.empty()
                }

                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(20, scrollView.contentSize.height - visibleHeight)

                return y > threshold ? Observable.just(()) : Observable.empty()
        }
    }
}
