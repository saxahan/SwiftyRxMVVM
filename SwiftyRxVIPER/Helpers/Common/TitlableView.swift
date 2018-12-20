//
//  TitlableView.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 20.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

protocol TitlableView {
    func setTitle(_ title: String)
}

extension TitlableView where Self: UIViewController {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }
}
