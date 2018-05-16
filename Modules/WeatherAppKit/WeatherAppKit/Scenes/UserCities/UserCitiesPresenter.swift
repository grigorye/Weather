//
//  UserCitiesPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCitiesPresenter : UserCitiesActionsViewDelegate /* !!! */ {
}

class UserCitiesPresenterImp : UserCitiesPresenter {
    
    let router: UserCitiesRouter
    
    init(router: UserCitiesRouter) {
        self.router = router
    }
    
    func selectedAddCity() {
        router.routeToAddCity()
    }
}
