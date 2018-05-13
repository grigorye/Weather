//
//  CitySearchInputViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchInputViewDelegate : class {
    
    func citySearchInputDidChange(_ text: String)
    func citySearchInputDidCancel()
}

protocol CitySearchInputView : View {
    
    var delegate: CitySearchInputViewDelegate! { get set }
}

class CitySearchInputViewController : UIViewController, CitySearchInputView {
    
    weak var delegate: CitySearchInputViewDelegate!
    
    @IBOutlet private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://stackoverflow.com/q/19141886/1859783
        searchBar.subviews.forEach { $0.clipsToBounds = false }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
}

extension CitySearchInputViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate.citySearchInputDidCancel()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate.citySearchInputDidChange(searchText)
    }
}
