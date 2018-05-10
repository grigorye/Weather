//
//  CitySearchResultsListViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

struct CitySearchResultsItemViewModel {
    
    let cityName: String
    
    let userInfo: Any!
}

protocol CitySearchResultsListViewDelegate : class {
    
    func didSelectCity(for: CitySearchResultsItemViewModel)
}

protocol CitySearchResultsListView : class {
    
    var delegate: CitySearchResultsListViewDelegate! { get set }
    var searchResults: [CitySearchResultsItemViewModel] { get set }
}

class CitySearchResultsListViewController : UITableViewController, CitySearchResultsListView {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CitySearchResultsListCell", bundle: .current), forCellReuseIdentifier: defaultCellReuseIdentifier)
    }
    
    func configureCell(_ cell: UITableViewCell, with item: CitySearchResultsItemViewModel) {
        let cell = cell as! CitySearchResultsItemView
        cell.model = item
    }
    
    // MARK: - <CitySearchResultsView>
    
    weak var delegate: CitySearchResultsListViewDelegate!
    
    var searchResults: [CitySearchResultsItemViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - <UITableViewDelegate>
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchResults[indexPath.row]
        delegate.didSelectCity(for: item)
    }
    
    // MARK: - <UITableViewDataSource>
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellReuseIdentifier, for: indexPath)
        let item = searchResults[indexPath.row]
        configureCell(cell, with: item)
        return cell
    }
}
