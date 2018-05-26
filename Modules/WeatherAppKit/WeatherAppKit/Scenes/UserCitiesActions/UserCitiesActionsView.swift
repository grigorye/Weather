//
//  UserCitiesActionsView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol UserCitiesActionsViewDelegate : class {
    
    func selectedAddCity()
}

protocol UserCitiesActionsView : View_V2 {
    
    var delegate: UserCitiesActionsViewDelegate! { get set }
}
