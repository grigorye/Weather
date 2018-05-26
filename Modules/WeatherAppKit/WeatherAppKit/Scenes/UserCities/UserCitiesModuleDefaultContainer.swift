//
//  UserCitiesModuleDefaultContainer.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func userCitiesModuleDefaultContainer(parent: Container?) -> Container {
    
    let container = Container(parent: parent)
    
    container.do {
        $0.register(UserCitiesModule.self) { _ in
            let module = UserCitiesModuleImp(parentContainer: container)
            retain(container.resolve(UserCityListModule.self)!, in: module)
            retain(container.resolve(UserCitiesActionsModule.self)!, in: module)
            return module
        }
        $0.register(UserCityListModule.self) { _ in
            UserCityListModuleImp(parentContainer: container)
        }
        $0.register(UserCitiesActionsModule.self) { _ in
            UserCitiesActionsModuleImp(parentContainer: container)
        }
    }

    return container
}

func newUserCitiesViewController(parentContainer: Container?) -> UIViewController {
    
    let container = userCitiesModuleDefaultContainer(parent: parentContainer)
    
    let viewController = container.resolve(UserCitiesModule.self)!.newViewController(parentContainer: container)
    return viewController
}
