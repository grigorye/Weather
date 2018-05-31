//
//  MainScene.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 28/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

func newMainSceneContainer(parent: Container, registerSubmodules: (Container) -> Void = registerMainSceneSubmodules) -> Container {
    
    let container = Container(parent: parent)
    
    container.do {
        $0.register(StoryboardContainerProvider.self) { [unowned container] _ in
            StoryboardContainerProvider(container: container)
        }
        registerSubmodules($0)
    }
    
    parent.do {
        $0.register(MainModule.self, factory: { [unowned container] r in
            let module = MainModuleImp(parentContainer: container)
            retain(container.resolve(UserCitiesModule.self)!, in: module)
            return module
        })
    }
    
    return container
}

func registerMainSceneSubmodules(in container: Container) {
    
    registerUserCitiesScene(in: container)
}

public func newMainViewController(parentContainer: Container = sharedContainer) -> UIViewController {
    
    let container = newMainSceneContainer(parent: parentContainer)
    
    let module = container.resolve(MainModule.self)!
    let viewController = module.newViewController()
    return viewController
}
