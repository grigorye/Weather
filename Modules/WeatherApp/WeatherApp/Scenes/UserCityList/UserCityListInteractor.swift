//
//  UserCityListInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxCocoa
import RxSwift
import Result
import Then

extension Array : Then {
    
}
protocol UserCityListInteractor {
    
    func userCitiesWithWeatherAndRefresher() -> (Observable<[UserCityWithWeather]>, refresher: () -> Void)
    
    var userCities: Observable<[UserCity]> { get }
    
    func delete(_: UserCity)
}

class UserCityListInteractorImp : UserCityListInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    let weatherProvider: WeatherProvider
    let locationService: LocationService
    
    deinit {()}
    
    init(userCitiesProvider: UserCitiesProvider, weatherProvider: WeatherProvider, locationService: LocationService) {
        
        self.userCitiesProvider = userCitiesProvider
        self.weatherProvider = weatherProvider
        self.locationService = locationService
    }
}

extension UserCityLocation {
    var isCurrentLocation: Bool {
        switch self {
        case .currentLocation:
            return true
        default:
            return false
        }
    }
}

extension UserCityListInteractorImp {
    
    // MARK: - <UserCityListInteractor>
    
    var userCities: Observable<[UserCity]> {
        return userCitiesProvider.userCities.share(replay: 1, scope: .forever)
    }
    
    func updateCurrentLocation(from: CityCoordinate) {
        let disposeBag = DisposeBag()
        userCities.subscribe(onNext: { (userCities: [UserCity]) in
            if let userLocation = userCities.first(where: { $0.location.isCurrentLocation }) {
                print(userLocation)
            }
        }).disposed(by: disposeBag)
    }
    
    func userCitiesWithWeatherAndRefresher() -> (Observable<[UserCityWithWeather]>, refresher: () -> Void) {
        
        var last: (() -> Void)?
        
        let observable = Observable<[UserCityWithWeather]>.create { [unowned self, locationService] observer in
            
            return self.userCities.subscribe(onNext: { [weak self] (userCities) in
                
                last = {
                    let next: [UserCityWithWeather] = userCities.map { (userCity: $0, weatherInfo: nil) }
                    
                    observer.onNext(next)
                    
                    let locations = userCities.map { $0.location }
                    let userLocationIndex = locations.index(where: { $0.isCurrentLocation })
                    
                    if (nil != userLocationIndex) && locationService.timeIntervalSinceLastUpdate > 600 {
                        locationService.queryCurrentLocation(completionHandler: { [weak self] (result) in
                            switch result {
                            case .success(let coordinate):
                                self?.updateCurrentLocation(from: coordinate)
                            case .failure(let error):
                                print(error)
                            }
                        })
                    }
                    let (indexOfCurrentLocationToSkip, locationPredicates): (Int?, [WeatherLocationPredicate]) = {
                        
                        guard let userLocationIndex = userLocationIndex else {
                            return (nil, userCities.map { $0.location.weatherLocationPredicate })
                        }
                        
                        guard let currentCoordinate = locationService.currentCoordinate else {
                            return (userLocationIndex, {
                                var adjustedValue = userCities
                                adjustedValue.remove(at: userLocationIndex)
                                return adjustedValue.map { $0.location.weatherLocationPredicate }
                            }())
                        }
                        
                        return (nil, userCities.map { $0.location }.map {
                            switch $0 {
                            case .currentLocation:
                                return .coordinate(currentCoordinate)
                            default:
                                return $0.weatherLocationPredicate
                            }
                        })
                    }()
                    self?.weatherProvider.queryWeather(for: locationPredicates, completion: { (results) in
                        let adjustedUserCities = userCities.with {
                            guard let indexOfCurrentLocationToSkip = indexOfCurrentLocationToSkip else {
                                return
                            }
                            $0.remove(at: indexOfCurrentLocationToSkip)
                        }
                        assert(adjustedUserCities.count == results.count)
                        let userCitiesWithWeather = (0..<results.count).map {
                            (adjustedUserCities[$0], results[$0].value)
                        }
                        let currentLocationAwareUserCitiesWithWeather = userCitiesWithWeather.with {
                            guard let indexOfCurrentLocationToSkip = indexOfCurrentLocationToSkip else {
                                return
                            }
                            let oldUserLocationAndWheather = next[indexOfCurrentLocationToSkip]
                            $0.insert(oldUserLocationAndWheather, at: indexOfCurrentLocationToSkip)
                        }
                        DispatchQueue.main.async {
                            observer.onNext(currentLocationAwareUserCitiesWithWeather)
                        }
                    })
                }
                last!()
            })
        }
        let refresher = {
            last?()
            ()
        }
        return (observable, refresher: refresher)
    }

    func delete(_ userCity: UserCity) {
        
        try! userCitiesProvider.delete(userCity)
    }
}
