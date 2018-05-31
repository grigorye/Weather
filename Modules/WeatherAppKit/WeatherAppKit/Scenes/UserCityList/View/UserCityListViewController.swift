//
//  UserCityListViewController.swift
//  Weather
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Then

class UserCityListViewController : UITableViewController, UserCityListView {
    
    // MARK: - <UserCityListView>
    
    weak var delegate: UserCityListViewDelegate!

    var itemViewModels: Observable<[UserCityListItemViewModel]>! {
        didSet {
            configureView()
        }
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserCityListCell", bundle: .current), forCellReuseIdentifier: "UserCityListCell")
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: -
    
    private let disposeBag = DisposeBag()
    
    func configureView() {
        tableView.isEditing = false
        
        let animatedDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<Int, UserCityListItemViewModel>>(configureCell: { _, tableView, indexPath, userCity in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCityListCell", for: indexPath)
            (cell as! UserCityListItemView).model = userCity
            return cell
        })
        animatedDataSource.canEditRowAtIndexPath = { _, _  in
            return true
        }
        animatedDataSource.canMoveRowAtIndexPath = { _, _  in
            return false
        }

        tableView.dataSource = nil
        
        itemViewModels
            .map { [AnimatableSectionModel(model: 0, items: $0)] }
            .bind(to: tableView.rx.items(dataSource: animatedDataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { [unowned self] indexPath -> UserCityListItemViewModel in
                return try self.tableView.rx.model(at: indexPath)
            }
            .subscribe(onNext: { [unowned self] (itemViewModel) in
                self.delegate.selected(itemViewModel)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .map { [unowned self] indexPath -> UserCityListItemViewModel in
                return try self.tableView.rx.model(at: indexPath)
            }
            .subscribe(onNext: { [unowned self] (itemViewModel) in
                self.delegate.deleted(itemViewModel)
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - Refresh
    
    @IBAction func refresh(_ sender: Any) {
        delegate.triggeredRefresh()
    }
    
    func beginRefreshing() {
        refreshControl?.beginRefreshing()
    }
    
    func endRefreshing() {
        refreshControl?.endRefreshing()
    }

    // MARK: -
    
    deinit {()}
}
