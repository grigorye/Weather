//
//  VIPERModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol ContainerView : class {}

protocol View : class {}

protocol ModuleStoryboarding {
    
    static var storyboardName: String { get }
}

protocol ModuleNonView {
    
    associatedtype Interactor
    associatedtype Presenter
    associatedtype Router
}

typealias _View = View

protocol ViewModule : ModuleNonView, ModuleStoryboarding {
    
    associatedtype View
    associatedtype ViewController: _View
}

typealias _ContainerView = ContainerView

protocol ContainerViewModule : ModuleNonView, ModuleStoryboarding {
    
    associatedtype ContainerView
    associatedtype ViewController: _ContainerView
}

import UIKit

extension ModuleStoryboarding {
    
    static func instantiateViewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .current)
        let viewController = storyboard.instantiateInitialViewController()!
        
        return viewController
    }
}
