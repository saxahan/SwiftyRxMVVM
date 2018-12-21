//
//  RepositorySearchTableViewCell.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

class RepositorySearchTableViewCell: UITableViewCell, Identifiable, Settable {

    typealias Element = Repository

    @IBOutlet weak var btnAvatar: CircularImageButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblRepo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(_ element: Repository) {
        let owner = element.owner
        btnAvatar?.imageUrl = owner.avatarUrl
        lblUsername?.text = owner.username
        lblRepo?.text = element.name
    }

    @IBAction func avatarTapped(_ sender: Any) {
        // TODO: open user detail screen
    }

}
