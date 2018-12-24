//
//  ServiceState.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case offline
    case limitReached
    case networkError
}

extension ServiceError {
    var localizedDescription: String {
        switch self {
        case .offline:
            return "SERVICE_OFFLINE".localized
        case .limitReached:
            return "SERVICE_LIMIT_REACHED".localized
        case .networkError:
            return "SERVICE_NETWORK_ERROR".localized
        }
    }
}
