//
//  UserCitiesActionsViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class UserCitiesActionsViewController : UIViewController {
    
    weak var delegate: UserCitiesActionsViewDelegate!
    
    @IBAction func selectedAddCity(_ sender: AnyObject) {
        delegate.selectedAddCity()
    }
}
