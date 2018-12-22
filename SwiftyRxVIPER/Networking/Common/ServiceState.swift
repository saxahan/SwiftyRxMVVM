//
//  ServiceState.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import RxSwift

enum ServiceError: Error {
    case offline
    case limitReached
    case networkError
}
