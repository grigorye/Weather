//
//  UserCityListContainerViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class UserCitiesViewController : UserCityListViewController /* !!! */, UserCitiesContainerView {

    var listViewController : UIViewController {
        return self
    }
    
    var actionsViewController : UIViewController {
        _ = view
        return _footerViewController!
    }
    
    private var _footerViewController: UIViewController!
    
    // MARK: -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "footer"?:
            _footerViewController = segue.destination
        default: ()
        }
    }
}
