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
    case list
    case error(Error)
}

protocol CitySearchResultsView : class {
    
    var state: CitySearchResultsViewState { get set }
}

class CitySearchResultsViewController : UIViewController, CitySearchResultsView, CitySearchResultsConsumerProvider {
    
    var interactor: CitySearchResultsInteractor = CitySearchResultsInteractorImp()
    
    var state: CitySearchResultsViewState = .loading {
        didSet {
            configureView()
        }
    }
    
    @IBOutlet private var errorView: UIView!
    @IBOutlet private var listView: UIView!
    @IBOutlet private var loadingView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.view = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "listView"?:
            interactor.listView = (segue.destination as! CitySearchResultsListView)
        default: ()
        }
    }
    
    // MARK: - CitySearchResultsConsumerProvider
    
    var citySearchResultsConsumer: CitySearchResultsConsumer {
        return interactor
    }
}
