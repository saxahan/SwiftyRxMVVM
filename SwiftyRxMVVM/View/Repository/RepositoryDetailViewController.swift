//
//  RepositoryDetailViewController.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 24.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: BindableViewController<RepositoryDetailViewModel> {

    @IBOutlet weak var lblRepoDetail: UILabel!
    @IBOutlet weak var userAvatarButton: UserAvatarButton!
    @IBOutlet weak var lblUsername: UILabel!

    override func bindViews() {
        viewModel.repositoryTrigger
            .asObservable()
            .map { $0 }
            .subscribe(onNext: { [unowned self] repo in
                let attrRepoText = repo.toString.highlightWords(in: repo.name, attributes: [[
                    .font: UIFont.boldSystemFont(ofSize: 17),
                    .foregroundColor: UIColor.black
                    ]])
                self.lblRepoDetail.attributedText = attrRepoText
            })
            .disposed(by: viewModel.disposeBag)

        viewModel.userTrigger
            .asObservable()
            .map { $0 }
            .subscribe(onNext: { [unowned self] user in
                self.userAvatarButton.imageUrl = user.avatarUrl

                let paragStyle = NSMutableParagraphStyle()
                paragStyle.alignment = .center

                let detailText = user.toString
                let attrText = detailText.highlightWords(in: detailText, attributes: [[
                    .paragraphStyle: paragStyle
                    ]])

                attrText.addAttributes([
                    .font: UIFont.boldSystemFont(ofSize: 16),
                    .foregroundColor: UIColor.black
                    ], range: NSString(string: detailText).range(of: user.username ?? ""))

                self.lblUsername.attributedText = attrText
            })
            .disposed(by: viewModel.disposeBag)

        userAvatarButton.rx.tap.bind { [unowned self] _ in
            if let vc = self.viewModel.didTappedAvatar() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        .disposed(by: viewModel.disposeBag)
    }
}
