//
//  RepositoryListViewController.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class RepositoryListViewController: BindableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RepositoryListViewModel!

    override func bindViews() {
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(resource: R.nib.repositoryTableViewCell), forCellReuseIdentifier: RepositoryTableViewCell.identifier)

        viewModel.elements.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryTableViewCell.identifier, cellType: RepositoryTableViewCell.self)) { (_, item, cell) in
                cell.setup(item)
            }
            .disposed(by: viewModel.disposeBag)

        tableView.rx.itemSelected
            .bind() { [unowned self] indexPath in
//                self.didSelectRow(ip: ip.row)
            }
            .disposed(by: viewModel.disposeBag)

//        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
//            .map { _ in () }
//            .bind(to: viewModel.refreshTrigger)
//            .disposed(by: disposeBag)

        searchBar
            .rx.text
            .orEmpty
            .bind(to: viewModel.searchTrigger)
            .disposed(by: viewModel.disposeBag)

        tableView.rxReachedBottom
            .map{ _ in ()}
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: viewModel.disposeBag)

        viewModel.loading
            .asObservable()
            .bind(to: isLoading(for: self.view)!)
            .disposed(by: viewModel.disposeBag)

        viewModel.error
            .asObservable()
            .bind(to: onError()!)
            .disposed(by: viewModel.disposeBag)
    }

    override func isLoading(for view: UIView) -> AnyObserver<Bool>? {
        return Binder(view, binding: { (_, isLoading) in
            switch isLoading {
            case true:
                LoaderHUD.shared.showOnWindow()
            case false:
                LoaderHUD.shared.hide()
            }
        }).asObserver()
    }

    override func onError() -> AnyObserver<Error>? {
        return Binder(view, binding: { (_, error) in
            LoaderHUD.shared.showOnWindow(for: .error, error.localizedDescription)
        }).asObserver()
    }

}
