//
//  CitySearchInputView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchInputView : View {
    
    var delegate: CitySearchInputViewDelegate! { get set }
}
