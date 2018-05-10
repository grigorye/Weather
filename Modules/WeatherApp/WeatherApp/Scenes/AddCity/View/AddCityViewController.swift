//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol AddCityViewDelegate : class {

    func citySearchInputDidChange(_ text: String)
}

protocol AddCityView : class {
    
    var delegate: AddCityViewDelegate! { get set }
}

class AddCityViewController : UIViewController, AddCityView, CitySearchInputViewDelegate {
    
    deinit {()}
    
    // MARK: - <AddCityView>
    
    weak var delegate: AddCityViewDelegate!
    
    // MARK: - <CitySearchInputViewDelegate>
    
    func citySearchInputDidChange(_ text: String) {
        delegate.citySearchInputDidChange(text)
    }
    
    // MARK: -
    
    @IBOutlet private var _searchContainerView: UIStackView!
    
    var searchContainerView: UIStackView {
        _ = view
        return _searchContainerView
    }
    
    // MARK: -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "searchInput":
            let childSearchInputView = segue.destination as! CitySearchInputView
            childSearchInputView.delegate = self
        default: ()
        }
    }
}
