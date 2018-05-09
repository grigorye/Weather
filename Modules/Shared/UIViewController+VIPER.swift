//
//  UIViewController+VIPER.swift
//  GEUIKit
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol PresenterOwner {
    associatedtype Presenter
    var presenter: Presenter { get }
}

class ModuleViewController : UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadPresenter()
        presenterDidLoad()
    }
    
    func presenterDidLoad() {
    }
    
    @objc dynamic func loadPresenter() {
    }
}
