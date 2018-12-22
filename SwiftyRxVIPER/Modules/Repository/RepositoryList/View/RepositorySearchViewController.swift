//
//  RepositorySearchViewController.swift
//  SwiftyRxVIPER
//
//  Created by Yunus Alkan on 21.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Moya

class RepositorySearchViewController: UIViewController {

    var presenter: ViewToPresenterRepositoryListProtocol?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()

    var repositories: RepositoryList!
    var page = 1
    var limit = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewRx()
        setupSearchRx()
    }

    func setupTableViewRx() {
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(resource: R.nib.repositorySearchTableViewCell), forCellReuseIdentifier: RepositorySearchTableViewCell.identifier)


        tableView.rx.contentOffset.subscribe { [unowned self] _ in
            if self.tableView.isNearBottomEdge() {
                let query = self.searchBar.text ?? ""
                if !query.isEmpty {
                    self.page += 1
                    self.presenter?.startSearchingRepositories(query: query, page: self.page, limit: self.limit, isPagination: true)
//                    self.presenter?.fetchNextRepositories(query: query, page: self.page, limit: self.limit)
                }
            }
        }.disposed(by: disposeBag)
    }

    func setupSearchRx() {
        _ = searchBar
            .rx.text
            .orEmpty
            .asDriver()
            .debounce(1.5)
            .distinctUntilChanged()
            .drive(onNext: { (query) in
                if !query.isEmpty {
                    self.page = 1
                    self.presenter?.startSearchingRepositories(query: query, page: self.page, limit: self.limit, isPagination: false)
                }
            })
    }

}

extension RepositorySearchViewController: PresenterToViewRepositoryListProtocol {
    func onSearchRepositorySuccess(repositoryList: RepositoryList, isPagination: Bool) {
        tableView.dataSource = nil

//        var items = repositoryList.items
//
//        if isPagination {
//            items += items
//        }


        Observable.from(optional: repositoryList.items)
            .filterEmpty()
            .bind(to: tableView.rx.items(cellIdentifier: RepositorySearchTableViewCell.identifier, cellType: RepositorySearchTableViewCell.self)) { _, element, cell in
                cell.setup(element)
            }
            .disposed(by: disposeBag)
    }

    func onSearchRepositoryFailed(error: Error) {
        debugPrint(error)
    }
}
