//
//  Modelable.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 24.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

 protocol Modelable {
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
}
