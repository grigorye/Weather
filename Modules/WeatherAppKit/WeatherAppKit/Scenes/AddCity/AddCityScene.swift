//
//  AddCityScene.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

func newAddCitySceneContainer(parent: Container?, registerSubmodules: (Container) -> Void = registerAddCitySubmodules) -> Container {
    
    let container = Container(parent: parent)
    container.do {
        $0.register(StoryboardContainerProvider.self) { [unowned container] _ in
            StoryboardContainerProvider(container: container)
        }
        
        registerSubmodules($0)
        
        $0.register(AddCityModule.self) { [unowned container] r in
            let module = AddCityModuleImp(parentContainer: container)
            retain(container.resolve(CitySearchInputModule.self)!, in: module)
            return module
        }
    }
    return container
}

func registerAddCitySubmodules(in container: Container) {
    
    container.register(CitySearchInputModule.self) { [unowned container] _ in
        CitySearchInputModuleImp(parentContainer: container)
    }
}

func newAddCityViewController(parentContainer: Container?) -> UIViewController {
    
    let container = newAddCitySceneContainer(parent: parentContainer)
    
    let module = container.resolve(AddCityModule.self)!
    let viewController = module.newViewController()
    return viewController
}
