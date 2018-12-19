//
//  EnvironmentType.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

protocol EnvironmentType {
    static var baseUrl: URL { get }
}

extension EnvironmentType {
    static var baseHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
