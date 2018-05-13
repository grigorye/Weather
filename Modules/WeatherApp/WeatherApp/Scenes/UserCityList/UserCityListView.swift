//
//  UserCityListView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol UserCityListView : class {
    
    var delegate: UserCityListViewDelegate! { get set }
    
    var itemViewModels: Observable<[UserCityListItemViewModel]>! { get set }
    
    func beginRefreshing()
    func endRefreshing()
}
