//
//  APIType.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

protocol APIType {
    associatedtype Environment: EnvironmentType
    var Environment: EnvironmentType {get set}
}
