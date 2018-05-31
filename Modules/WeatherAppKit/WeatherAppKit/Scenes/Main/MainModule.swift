//
//  MainModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

extension MainViewController : MainContainerView, ContainerView_V2 {}

protocol MainModule : class {
    
    func newViewController() -> UIViewController
}

class MainModuleImp : MainModule, ContainerViewModule_V2 {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container
    }
    
    deinit {()}
    
    // MARK: -
    
    typealias ContainerView = MainContainerView
    
    typealias ViewController = MainViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ()
    
    typealias Router = ()
    
    let storyboardName = "Main"

    var viewControllerStoryboardID: String? {
        guard !UserDefaults.standard.bool(forKey: "forceDebugScene") else {
            return "Debug"
        }
        return nil
    }

    let container: Container
}
