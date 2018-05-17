//
//  UserCityListPresenterTests.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import RxSwift

class UserCityListPresenter_OnLoadContent_Tests : QuickSpec {
    
    override func spec() {
        
        let view = UserCityListViewMock()
        let interactor = UserCityListInteractorMock()
        let router = UserCityListRouterMock()
        
        let presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        
        context("") {
            expect(interactor.clearRefreshingForUserCities_$invocationCount) == 0
            expect(interactor.observableUserCities_$invocationCount) == 0
            expect(interactor.refreshUserCities__$invocationCount) == 0
            expect(view.itemViewModels_$setCount) == 0

            presenter.loadContent()
            
            it("should invoke interactor.clearRefreshingForUserCities") {
                expect(interactor.clearRefreshingForUserCities_$invocationCount) == 1
            }
            it("should query interactor.observableUserCities") {
                expect(interactor.observableUserCities_$invocationCount) > 1
            }
            it("should invoke interactor.refreshUserCities(_:)") {
                expect(interactor.refreshUserCities__$invocationCount) == 1
            }
            it("should set view.itemViewModels") {
                expect(view.itemViewModels_$setCount) == 1
            }
        }
    }
}

class UserCityListPresenter_ItemAddedToObservableUserCitiesInInteractor_Tests : QuickSpec {
    
    override func spec() {
        
        let view = UserCityListViewMock()
        let interactor = UserCityListInteractorMock()
        let router = UserCityListRouterMock()
        
        interactor.lastWeather_$ = BehaviorSubject(value: lastWeatherInfoSample)
        
        let presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        presenter.loadContent()

        let disposeBag = DisposeBag()
        var itemViewModels: [UserCityListItemViewModel] = []
        view.itemViewModels.subscribe(onNext: { (nextItemViewModels) in
            itemViewModels = nextItemViewModels
        }).disposed(by: disposeBag)

        context("") {
            expect(itemViewModels.count) == 0
            
            interactor.observableUserCities_$.onNext([userCitySample])

            it("should add an item to view.itemViewModels") {
                expect(itemViewModels.count) == 1
            }
        }
    }
}

class UserCityListPresenter_OnRefreshTriggeredInView_Tests : QuickSpec {
    
    override func spec() {
        
        let view = UserCityListViewMock()
        let interactor = UserCityListInteractorMock()
        let router = UserCityListRouterMock()
        
        interactor.lastWeather_$ = BehaviorSubject(value: lastWeatherInfoSample)
        
        let presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        presenter.loadContent()
        
        context("") {
            expect(view.endRefreshing_$invocationCount) == 0
            
            presenter.triggeredRefresh()
            
            it("should invoke view.endRefreshing") {
                expect(view.endRefreshing_$invocationCount).toEventually(equal(1))
            }
        }
    }
}

class UserCityListPresenter_OnDeletedInView_Tests : QuickSpec {
    
    override func spec() {
        
        let view = UserCityListViewMock()
        let interactor = UserCityListInteractorMock()
        let router = UserCityListRouterMock()
        
        interactor.lastWeather_$ = BehaviorSubject(value: lastWeatherInfoSample)
        
        let presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        presenter.loadContent()
        
        let disposeBag = DisposeBag()
        var itemViewModels: [UserCityListItemViewModel] = []
        view.itemViewModels.subscribe(onNext: { (nextItemViewModels) in
            itemViewModels = nextItemViewModels
        }).disposed(by: disposeBag)
        
        interactor.observableUserCities_$.onNext([userCitySample])
        
        context("") {
            expect(interactor.delete_$invocationCount) == 0
            
            presenter.deleted(itemViewModels[0])
            
            it("should invoke interactor.delete") {
                expect(interactor.delete_$invocationCount) == 1
            }
        }
    }
}

class UserCityListPresenter_OnSelectedInView_Tests : QuickSpec {
    
    override func spec() {
        
        let view = UserCityListViewMock()
        let interactor = UserCityListInteractorMock()
        let router = UserCityListRouterMock()
        
        interactor.lastWeather_$ = BehaviorSubject(value: lastWeatherInfoSample)
        
        let presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        presenter.loadContent()
        
        let disposeBag = DisposeBag()
        var itemViewModels: [UserCityListItemViewModel] = []
        view.itemViewModels.subscribe(onNext: { (nextItemViewModels) in
            itemViewModels = nextItemViewModels
        }).disposed(by: disposeBag)
        
        interactor.observableUserCities_$.onNext([userCitySample])
        
        context("") {
            expect(router.routeToUserCityWithLastWeather_$invocationCount) == 0
            
            presenter.selected(itemViewModels[0])
            
            it("should invoke router.routeToUserCityWithLastWeather") {
                expect(router.routeToUserCityWithLastWeather_$invocationCount) == 1
            }
        }
    }
}
