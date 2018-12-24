//
//  LoaderHUD.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation
import SVProgressHUD

enum LoaderState {
    case success, error, info
}

/// Wrapper manager of SVProgressHUD for simple test usages.

class LoaderHUD {
    static let shared = LoaderHUD()

    init() {
        SVProgressHUD.setHapticsEnabled(true)
    }

    private func show(in view: UIView, state: LoaderState = .success, message: String? = nil) {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setContainerView(view)

        if let status = message {
            switch state {
            case .success:
                SVProgressHUD.showSuccess(withStatus: status)
            case .error:
                SVProgressHUD.showError(withStatus: status)
            case .info:
                SVProgressHUD.showInfo(withStatus: status)
            }
        }
        else {
            // normal spinner
            SVProgressHUD.show()
        }
    }

    func showOnWindow(for state: LoaderState = .success, _ message: String? = nil) {
        hide()
        show(in: UIApplication.shared.keyWindow!, state: state, message: message)
    }

    func showInView(_ view: UIView, state: LoaderState = .success, _ message: String? = nil) {
        show(in: view, state: state, message: message)
    }

    func hide() {
        SVProgressHUD.dismiss()
    }
}
