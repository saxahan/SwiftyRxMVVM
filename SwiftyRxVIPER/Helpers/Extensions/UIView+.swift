//
//  UIView+.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIView {
    func setRounded(hasBorder: Bool = false, borderWidth: CGFloat = 1, borderColor: UIColor = .lightGray) {
        if frame.width > 0 {
            layer.cornerRadius = frame.width * 0.5
            layer.borderWidth = hasBorder ? borderWidth : 0
            layer.borderColor = hasBorder ? borderColor.cgColor : UIColor.clear.cgColor
            layer.masksToBounds = true
        }
    }
}
