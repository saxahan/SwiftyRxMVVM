//
//  Settable.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

protocol Settable {
    associatedtype Element
    func setup(_ element: Element)
}
