//
//  UserCityListViewController+UserCityCellTransitioningSource.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 20/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSIndexPath
import CoreGraphics
import UIKit.UITableView

extension UserCityListViewController : UserCityCellTransitioningSource {
    
    func index(for location: UserCityLocation) -> Int {
        
        var index: Int?
        _ = itemViewModels.subscribe(onNext: { (models) in
            index = models.index(where: { $0.userCityInfo.location == location })
        })
        return index!
    }
    
    func cellFrame(for location: UserCityLocation) -> CGRect {
        
        let row = index(for: location)
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath)!
        let cellFrameInSuperview = tableView.convert(cell.frame, to: tableView.superview)
        return cellFrameInSuperview
    }
}
