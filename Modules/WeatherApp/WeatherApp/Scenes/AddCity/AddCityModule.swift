//
//  AddCityModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

extension AddCityViewController {
    
    override func loadPresenter() {
        
        super.loadPresenter()
        
        let router: AddCityRouter = AddCityRouterImp(viewController: self, searchResultsContainerView: searchResultsContainerView)
        
        let presenter: AddCityPresenter = AddCityPresenterImp(interactor: AddCityInteractorImp(), router: router)
        
        self.presenter = presenter
        
        router.routeToNoSearch()
    }
}
