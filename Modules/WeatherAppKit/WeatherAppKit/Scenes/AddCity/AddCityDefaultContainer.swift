//
//  AddCityModuleDefaultContainer.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func addCityModuleDefaultContainer(parent: Container?) -> Container {
    
    let container = Container(parent: parent)
    
    container.do {
        $0.register(AddCityModule.self) { _ in
            let module = AddCityModuleImp(parentContainer: container)
            retain(container.resolve(CitySearchInputModule.self)!, in: module)
            return module
        }
        $0.register(CitySearchInputModule.self) { _ in
            CitySearchInputModuleImp(parentContainer: container)
        }
    }
    
    return container
}

func newAddCityViewController(parentContainer: Container?) -> UIViewController {
    
    let container = addCityModuleDefaultContainer(parent: parentContainer)
    
    let viewController = container.resolve(AddCityModule.self)!.newViewController(parentContainer: container)
    return viewController
}
