//
//  UserCitiesActionsPresenter.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 26/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCitiesActionsPresenter : UserCitiesActionsViewDelegate {
}

class UserCitiesActionsPresenterImp : UserCitiesActionsPresenter {
    
    let router: UserCitiesActionsRouter
    
    init(router: UserCitiesActionsRouter) {
        self.router = router
    }
    
    func selectedAddCity() {
        router.routeToAddCity()
    }
}
