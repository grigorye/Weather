//
//  CitySearchInputPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

protocol CitySearchInputPresenter : CitySearchInputViewDelegate {
    
    var delegate: CitySearchInputDelegate! { get set }
    
    func loadContent()
}

class CitySearchInputPresenterImp : CitySearchInputPresenter {
    
    let interactor: CitySearchInputInteractor
    unowned let view: CitySearchInputView
    
    init(view: CitySearchInputView, interactor: CitySearchInputInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - <CitySearchInputPresenter>
    
    weak var delegate: CitySearchInputDelegate!
    
    func loadContent() {
        updateViewForInputType()
    }
    
    // MARK: - <CitySearchInputViewDelegate>
    
    func citySearchInputDidChange(_ text: String) {
        delegate.citySearchInputDidChange(text, type: interactor.currentInputType)
    }
    
    func citySearchInputDidCancel() {
        delegate.citySearchInputDidCancel()
    }
    
    func citySearchSelectInputType() {
        
        interactor.currentInputType = CitySearchInputType(rawValue: interactor.currentInputType.rawValue + 1) ?? CitySearchInputType(rawValue: 0)!
        updateViewForInputType()
    }
    
    // MARK: -
    
    func updateViewForInputType() {
        view.inputTypeIcons = {
            switch interactor.currentInputType {
            case .cityName:
                return CitySearchInputTypeIcons(normal: .bundled(#imageLiteral(resourceName: "icons8-zip_code")), selected: .bundled(#imageLiteral(resourceName: "icons8-zip_code_filled")))
            case .zipCode:
                return CitySearchInputTypeIcons(normal: .bundled(#imageLiteral(resourceName: "icons8-city")), selected: .bundled(#imageLiteral(resourceName: "icons8-city_filled")))
            }
        }()
        view.prompt = {
            switch interactor.currentInputType {
            case .cityName:
                return NSLocalizedString("City", comment: "")
            case .zipCode:
                return NSLocalizedString("Postcode", comment: "")
            }
        }()
    }
}
