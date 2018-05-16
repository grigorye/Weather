//
//  CitySearchInputViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class CitySearchInputViewController : UIViewController, CitySearchInputView {
    
    // MARK: - <CitySearchInputView>
    
    weak var delegate: CitySearchInputViewDelegate!
    
    var prompt: String = "" {
        didSet {
            _ = view
            searchBar.placeholder = prompt
        }
    }
    var inputTypeIcons: CitySearchInputTypeIcons! {
        didSet {
            _ = view
            searchBar.setImage(inputTypeIcons.normal, for: .bookmark, state: .normal)
            searchBar.setImage(inputTypeIcons.selected, for: .bookmark, state: .selected)
        }
    }

    // MARK: -
    
    @IBOutlet private var searchBar: UISearchBar!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
}

extension CitySearchInputViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate.citySearchInputDidCancel()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        delegate.citySearchSelectInputType()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate.citySearchInputDidChange(searchText)
    }
}
