//
//  UserTableViewCell.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell, Identifiable, Settable {

    typealias Element = User

    @IBOutlet weak var imgViewAvatar: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewAvatar.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(_ element: User) {
        if let avatarUrl = element.avatarUrl {
            imgViewAvatar.sd_setImage(with: URL(string: avatarUrl))
        }

        let paragStyle = NSMutableParagraphStyle()
        paragStyle.alignment = .center

        let username = element.username ?? ""
        let email = element.email ?? ""
        let location = element.location ?? ""
        let detailText = "\(username)-\(email)\n\(location)"
        let attrText = detailText.highlightWords(in: detailText, attributes: [[
            .paragraphStyle: paragStyle
            ]])

        attrText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.black
            ], range: NSString(string: detailText).range(of: username))

        lblDetail.attributedText = attrText
    }
}
