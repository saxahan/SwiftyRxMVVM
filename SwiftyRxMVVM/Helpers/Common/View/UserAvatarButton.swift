//
//  UserAvatarButton.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 22.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import SDWebImage

class UserAvatarButton: UIButton {

    var imageUrl: String? {
        didSet {
            sd_setImage(with: URL(string: imageUrl ?? ""), for: .normal, placeholderImage: UIImage(named: "avatar-placeholder")) { [weak self] (dImage, _, _, _) in
                self?.setImage(dImage?.withRenderingMode(.alwaysOriginal), for: .normal)
                self?.setNeedsDisplay()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView?.contentMode = .scaleAspectFill
        setRounded()
    }
}
