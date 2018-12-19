//
//  DevelopmentEnv.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

struct DevelopmentEnv: EnvironmentType {
    static var baseUrl: URL {
        return URL(string: "https://api.github.com")!
    }
}
