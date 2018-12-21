//
//  CircularImageButton.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import SDWebImage

class CircularImageButton: UIButton {
    
    var imageUrl: String? {
        didSet {
            self.sd_setImage(with: URL(string: imageUrl ?? ""), for: .normal, placeholderImage: UIImage(named: "avatar-placeholder"))
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let imageView = self.imageView {
            self.imageView?.layer.cornerRadius = imageView.frame.width / 2
            self.imageView?.layer.masksToBounds = true
        }
    }

}
