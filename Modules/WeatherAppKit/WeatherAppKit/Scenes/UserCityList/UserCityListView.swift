//
//  UserCityListView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol UserCityListView : View_V2 {
    
    var delegate: UserCityListViewDelegate! { get set }
    
    var itemViewModels: Observable<[UserCityListItemViewModel]>! { get set }
    
    func beginRefreshing()
    func endRefreshing()
}

protocol UserCityListViewDelegate : class {
    
    func selected(_: UserCityListItemViewModel)
    func deleted(_: UserCityListItemViewModel)
    
    func triggeredRefresh()
}
