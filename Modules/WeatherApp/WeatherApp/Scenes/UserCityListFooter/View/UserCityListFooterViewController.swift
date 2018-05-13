//
//  UserCityListFooterViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol UserCityListFooterViewDelegate : class {
    
    func selectedAddCity()
}

protocol UserCityListFooterView : class {

    var delegate: UserCityListFooterViewDelegate! { get set }
}

class UserCityListFooterViewController : UIViewController, UserCityListFooterView {
    
    weak var delegate: UserCityListFooterViewDelegate!
    
    @IBAction func selectedAddCity(_ sender: AnyObject) {
        delegate.selectedAddCity()
    }
}
