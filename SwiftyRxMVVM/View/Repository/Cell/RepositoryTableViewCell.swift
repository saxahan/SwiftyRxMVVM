//
//  RepositoryTableViewCell.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryTableViewCell: BaseTableViewCell, Settable {

    typealias Element = Repository

    @IBOutlet weak var userAvatarButton: UserAvatarButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblRepo: UILabel!
    @IBOutlet weak var avatarWidthConstraint: NSLayoutConstraint!

    var bag = DisposeBag()

    var isForUserPage: Bool = false {
        didSet {
            userAvatarButton.isHidden = isForUserPage
            lblUsername.isHidden = isForUserPage
            avatarWidthConstraint.constant = isForUserPage ? 0 : 80
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    func setup(_ element: Repository) {
        let owner = element.owner
        userAvatarButton?.imageUrl = owner.avatarUrl
        lblUsername?.text = owner.username

        let attrRepoText = element.toString.highlightWords(in: element.name, attributes: [[
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.black
            ]])
        lblRepo.attributedText = attrRepoText
    }
}
