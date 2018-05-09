//
//  CitySearchResultsViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsListViewDelegate : class {
    
    func didSelectCity(_: CityInfo)
}

protocol CitySearchResultsListView : class {
    
    var searchResults: [CityInfo] { get set }
}

class CitySearchResultsListViewController : UITableViewController, CitySearchResultsListView {
    
    weak var viewDelegate: CitySearchResultsListViewDelegate!
    
    var searchResults: [CityInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CitySearchResultsListCell", bundle: .current), forCellReuseIdentifier: "Cell")
    }
    
    func configureCell(_ cell: UITableViewCell, with city: CityInfo) {
        cell.textLabel!.text = city.name
    }
    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchResults[indexPath.row]
        viewDelegate.didSelectCity(city)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city = searchResults[indexPath.row]
        configureCell(cell, with: city)
        return cell
    }
}
