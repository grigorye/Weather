//
//  UserCityListItemView+Differentiator.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Differentiator

extension UserCityListItemViewModel : Equatable {}

func == (lhs: UserCityListItemViewModel, rhs: UserCityListItemViewModel) -> Bool {
    return (lhs.identifier == rhs.identifier)
}

extension UserCityListItemViewModel : IdentifiableType {
    
    typealias Identity = String
    
    var identity: String {
        return identifier
    }
}
