//
//  UserDetailViewController.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 23.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class UserDetailViewController: BindableViewController<UserDetailViewModel>, UITableViewDelegate {

    // pull to refresh example instance
    // I can make it more generic ...
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!

    override func bindViews() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.register(UINib(resource: R.nib.repositoryTableViewCell), forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        tableView.register(UINib(resource: R.nib.userTableViewCell), forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.delegate = self

        viewModel.dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { (dataSource, table, idxPath, _) in
                switch dataSource[idxPath] {
                case .UserSectionItem(let user):
                    let cell: UserTableViewCell = table.dequeueReusableCell(at: idxPath)
                    cell.setup(user)
                    return cell
                case .RepositorySectionItem(let repository):
                    let cell: RepositoryTableViewCell = table.dequeueReusableCell(at: idxPath)
                    cell.isForUserPage = true
                    cell.setup(repository)
                    return cell
                }
        },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.title
        }
        )

        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.refreshTrigger)
            .disposed(by: viewModel.disposeBag)

        rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .map { _ in () }
            .bind(to: viewModel.refreshTrigger)
            .disposed(by: viewModel.disposeBag)

        viewModel.sectionTrigger
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: viewModel.disposeBag)

        tableView.rx
            .modelSelected(SectionItem.self)
            .bind() { item in
                if let vc = self.viewModel?.didSelectRow(item) {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .disposed(by: viewModel.disposeBag)

        tableView.rxReachedBottom
            .map{ _ in ()}
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: viewModel.disposeBag)

        viewModel.loading
            .asObservable()
            .do(onNext: { [unowned self] isLoading in
                if isLoading {
                    self.refreshControl.endRefreshing()
                }
            })
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
                DispatchQueue.main.async {
                    LoaderHUD.shared.showOnWindow()
                }
            case false:
                DispatchQueue.main.async {
                    LoaderHUD.shared.hide()
                }
            }
        }).asObserver()
    }

    override func onError() -> AnyObserver<Error>? {
        return Binder(view, binding: { (_, error) in
            DispatchQueue.main.async {
                LoaderHUD.shared.showOnWindow(for: .error, (error as? ServiceError)?.localizedDescription ?? error.localizedDescription)
            }
        }).asObserver()
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerViewLabel = (view as? UITableViewHeaderFooterView)?.textLabel {
            headerViewLabel.textAlignment = .center
        }

        tableView.separatorStyle = section == 1 ? .singleLine : .none
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
}
