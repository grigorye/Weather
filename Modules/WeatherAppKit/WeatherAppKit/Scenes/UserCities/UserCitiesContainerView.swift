//
//  UserCitiesView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UIViewController

protocol UserCitiesContainerView : ContainerView {
    
    var listViewController: UIViewController { get }
    var actionsViewController: UIViewController { get }
}
