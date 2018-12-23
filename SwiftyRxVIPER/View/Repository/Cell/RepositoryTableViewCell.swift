//
//  RepositoryTableViewCell.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryTableViewCell: UITableViewCell, Identifiable, Settable {

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
        
        // "REPO_DETAILED" = "%@\nFork Count: %@   Issue Count: %@\nFull Name: %@";
        let repoName = element.name
        let repoFullname = element.fullName ?? ""
        let detailedRepoText = String(format: "REPO_DETAILED".localized, repoName, element.forksCount, element.openIssuesCount, repoFullname)
        let attrRepoText = detailedRepoText.highlightWords(in: repoName, attributes: [[
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.black
            ]])
        lblRepo.attributedText = attrRepoText
    }

    @IBAction func avatarTapped(_ sender: Any) {
    }
}
