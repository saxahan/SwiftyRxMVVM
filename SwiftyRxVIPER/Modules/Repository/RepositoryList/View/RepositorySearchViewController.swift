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

    var repositoryList: RepositoryList!
    var page = 1
    var limit = 20

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(resource: R.nib.repositorySearchTableViewCell), forCellReuseIdentifier: RepositorySearchTableViewCell.identifier)
        
        setupSearchRx()
    }

    func setupSearchRx() {
        _ = searchBar
            .rx.text
            .orEmpty
            .debounce(0.25, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                _ = self.presenter!.startSearchingRepositories(query: query, page: self.page, limit: self.limit)
            })
    }

}

extension RepositorySearchViewController: PresenterToViewRepositoryListProtocol {
    func onSearchRepositorySuccess(repositoryList: Observable<RepositoryList>) {
        tableView.dataSource = nil

        _ = repositoryList.subscribe { r in
            self.repositoryList = r.event.element
        }

        repositoryList
            .map{ $0.items }
            .filterEmpty()
            .bind(to: tableView.rx.items(cellIdentifier: RepositorySearchTableViewCell.identifier, cellType: RepositorySearchTableViewCell.self)) { _, element, cell in
                cell.setup(element)
            }
            .disposed(by: disposeBag)
    }

    func onSearchRepositoryFailed(error: Error) {

    }
}
