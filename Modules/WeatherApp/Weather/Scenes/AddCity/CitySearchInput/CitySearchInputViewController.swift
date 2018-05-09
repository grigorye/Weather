//
//  CitySearchInputViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchInputDelegate : class {
    
    func citySearchInputDidChange(_ text: String)
}

protocol CitySearchInputProvider : class {
    
    var delegate: CitySearchInputDelegate! { get set }
}

class CitySearchInputViewController : UIViewController, CitySearchInputProvider {
    
    weak var delegate: CitySearchInputDelegate!
    
    @IBOutlet private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://stackoverflow.com/q/19141886/1859783
        searchBar.subviews.forEach { $0.clipsToBounds = false }

        searchBar.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CitySearchInputViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "unwindFromCitySearchInput", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.citySearchInputDidChange(searchText)
    }
}
