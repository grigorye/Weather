//
//  StatusBarCoveringSearchBar.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UISearchBar

/// https://stackoverflow.com/q/19141886/1859783
class StatusBarCoveringSearchBar : UISearchBar {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        subviews.forEach { $0.clipsToBounds = false }
    }
}
