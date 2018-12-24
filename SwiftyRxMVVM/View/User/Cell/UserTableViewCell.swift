//
//  UserTableViewCell.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

class UserTableViewCell: BaseTableViewCell, Settable {

    typealias Element = User

    @IBOutlet weak var imgViewAvatar: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!

    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        imgViewAvatar.setRounded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    func setup(_ element: User) {
        if let avatarUrl = element.avatarUrl {
            imgViewAvatar.sd_setImage(with: URL(string: avatarUrl))
        }

        let paragStyle = NSMutableParagraphStyle()
        paragStyle.alignment = .center

        let detailText = element.toString
        let attrText = detailText.highlightWords(in: detailText, attributes: [[
            .paragraphStyle: paragStyle
            ]])

        attrText.addAttributes([
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.black
            ], range: NSString(string: detailText).range(of: element.username ?? ""))

        lblDetail.attributedText = attrText
    }
}
