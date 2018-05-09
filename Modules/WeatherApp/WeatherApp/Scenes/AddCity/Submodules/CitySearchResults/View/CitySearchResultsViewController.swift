//
//  CitySearchResultsViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

enum CitySearchResultsViewState {
    
    case loading
    case list([CityInfo])
    case error(Error)
}

protocol CitySearchResultsView : AnyObject {
    
    var state: CitySearchResultsViewState { get set }
}

class CitySearchResultsViewController : ModuleViewController, CitySearchResultsView {
    
    var presenter: CitySearchResultsPresenter!
    
    var state: CitySearchResultsViewState = .loading {
        didSet {
            if case .list(let cityInfos) = state {
                childListView.searchResults = cityInfos
            }
            configureView()
        }
    }
    
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var listView: UIView!
    @IBOutlet private var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

    private var switchingViewToShow: UIView {
        switch state {
        case .loading:
            return loadingView
        case .error:
            return errorView
        case .list:
            return listView
        }
    }
    
    lazy var switchingViews: [UIView] = [
        errorView,
        listView,
        loadingView
    ]
    
    func configureView() {
        switchingViews.forEach { $0.isHidden = true }
        switchingViewToShow.isHidden = false
    }
    
    private var childListView: CitySearchResultsListView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "list"?:
            childListView = forceCasted(segue.destination)
        default: ()
        }
    }
}
