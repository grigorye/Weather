//
//  UserCitiesSplitViewTransitioningSource.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import CoreGraphics

protocol UserCityCellTransitioningSource {
    
    func cellFrame(for: UserCityLocation) -> CGRect
}
