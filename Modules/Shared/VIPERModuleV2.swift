//
//  VIPERModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject

protocol ContainerView_V2 : class {}

protocol View_V2 : class {
}

protocol ModuleStoryboarding_V2 {
    
    var storyboardName: String { get }
    var container: Container { get }
}

protocol ModuleNonView_V2 {
    
    associatedtype Interactor
    associatedtype Presenter
    associatedtype Router
}

typealias _View_V2 = View_V2

protocol ViewModule_V2 : ModuleNonView_V2 {
    
    associatedtype View
    associatedtype ViewController: _View_V2
}

typealias _ContainerView_V2 = ContainerView_V2

protocol ContainerViewModule_V2 : ModuleNonView_V2, ModuleStoryboarding_V2 {
    
    associatedtype ContainerView
    associatedtype ViewController: _ContainerView_V2
}

import UIKit

extension ModuleStoryboarding_V2 {
    
    func instantiateViewController() -> UIViewController {
        
        let storyboard: UIStoryboard = SwinjectStoryboard.create(name: storyboardName, bundle: .current, container: container)
        let viewController = storyboard.instantiateInitialViewController()!
        
        return viewController
    }
}

extension ViewModule_V2 where Self: ModuleStoryboarding_V2 {
    
    func newViewController() -> UIViewController {
        
        return instantiateViewController()
    }
}

extension ContainerViewModule_V2 {
    
    func newViewController(parentContainer: Container? = sharedContainer) -> UIViewController {
        
        return instantiateViewController()
    }
}
