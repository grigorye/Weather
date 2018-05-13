//
//  CitySearchAlternativesViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchAlternativesViewDelegate : class {
    
    func selectedCurrentLocation()
    func selectedSelectOnMap()
}

protocol CitySearchAlternativesView : View {
    
    var delegate: CitySearchAlternativesViewDelegate! { get set }
}

class CitySearchAlternativesViewController : UITableViewController, CitySearchAlternativesView {
    
    @IBOutlet private var selectOnMapCell: UITableViewCell!
    @IBOutlet private var currentLocationCell: UITableViewCell!
    
    // MARK: - <CitySearchAlternativesViewDelegate>
    
    weak var delegate: CitySearchAlternativesViewDelegate!
    
    // MARK: - <UITableViewDelegate>
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView.cellForRow(at: indexPath) {
        case currentLocationCell:
            delegate.selectedCurrentLocation()
        case selectOnMapCell?:
            delegate.selectedSelectOnMap()
        default: ()
        }
    }
}
