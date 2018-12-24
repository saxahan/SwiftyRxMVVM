//
//  BaseTableViewCell.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 24.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, Identifiable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
