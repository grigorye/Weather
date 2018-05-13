//
//  CitySearchInputView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

struct CitySearchInputTypeIcons {
    
    let normal: UIImage
    let selected: UIImage
}

protocol CitySearchInputView : View {
    
    var delegate: CitySearchInputViewDelegate! { get set }
    
    var inputTypeIcons: CitySearchInputTypeIcons! { get set }
    var prompt: String { get set }
}

protocol CitySearchInputViewDelegate : class {
    
    func citySearchInputDidChange(_ text: String)
    func citySearchSelectInputType()
    func citySearchInputDidCancel()
}
