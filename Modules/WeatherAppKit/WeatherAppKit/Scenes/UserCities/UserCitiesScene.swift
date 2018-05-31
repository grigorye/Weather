//
//  UserCitiesSceneContainer.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 22/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func registerUserCitiesScene(in parentContainer: Container, registerSubmodules: (Container) -> Void = registerUserCitiesSceneSubmodules) {
    
    registerSubmodules(parentContainer)
    
    parentContainer.do {
        $0.register(UserCitiesModule.self) { [unowned parentContainer] r in
            let module = UserCitiesModuleImp(parentContainer: parentContainer)
            retain(r.resolve(UserCityListModule.self)!, in: module)
            retain(r.resolve(UserCitiesActionsModule.self)!, in: module)
            return module
        }
    }
}

func registerUserCitiesSceneSubmodules(in container: Container) {
    
    container.do {
        $0.register(UserCityListModule.self) { [unowned container] _ in
            UserCityListModuleImp(parentContainer: container)
        }
        $0.register(UserCitiesActionsModule.self) { [unowned container] _ in
            UserCitiesActionsModuleImp(parentContainer: container)
        }
    }
}
