//
//  UserCityRefresherImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Result
import Dispatch

class UserCityRefresherImp : UserCityRefresher {
    
    // MARK: - <UserCityRefresher>
    
    func refreshAsNecessary(_ userCities: [UserCity]) {
        
        let userLocation = userCities.first { $0.location.isCurrentLocation }
        
        var currentLocationIsObsolete: Bool {
            return true
        }
        
        // If necessary, update current location *first* and *then* refresh the corresponding user city.
        if (userLocation != nil) && currentLocationIsObsolete {
            
            self.refreshUserLocation()
            
            let userCitiesWithoutCurrentLocation = userCities.filter { !$0.location.isCurrentLocation }
            
            self.updateWeatherAsNecessary(for: userCitiesWithoutCurrentLocation)
            
        } else {
            
            self.updateWeatherAsNecessary(for: userCities)
        }
    }
    
    func clearRefreshingAsNecessary(for userCities: [UserCity]) {
        
        let affectedUserCities = userCities.filter { $0.hasWeatherQueryInProgress }
        dump(affectedUserCities, name: "clearRefreshingAffectedUserCities", maxDepth: 0).forEach { (userCity) in
            try! userCitiesProvider.setWeatherQueryCompleted(for: userCity, with: .failure(AnyError(CocoaError(.userCancelled))))
        }
    }
    
    // MARK: -
    
    func updateWeatherAsNecessaryForUserLocation(with coordinate: CityCoordinate) {
        
        _ = userCitiesProvider.observableUserCities.take(1).subscribe(onNext: { (userCities) in
            guard let userLocation = userCities.first(where: { $0.location.isCurrentLocation }) else {
                return
            }
            self.updateWeatherAsNecessary(for: [userLocation])
        })
    }
    
    var refreshingUserLocation = false
    
    func refreshUserLocation() {
        
        guard !refreshingUserLocation else {
            return
        }
        
        refreshingUserLocation = true
        locationService.queryCurrentLocation(completionHandler: { [weak self] (result) in
            self?.refreshingUserLocation = false
            switch result {
            case .success(let coordinate):
                self?.updateWeatherAsNecessaryForUserLocation(with: coordinate)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func updateWeatherAsNecessary(for userCities: [UserCity]) {
        
        let userCities = userCities.filter { (userCity) in
            guard !userCity.hasWeatherQueryInProgress else {
                return false
            }
            return true
        }
        
        try! userCitiesProvider.setWeatherQueryInProgress(for: userCities)
        
        let locations = userCities.map { $0.location }
        let locationPredicates: [WeatherLocationPredicate] = locations.map {
            switch $0 {
            case .currentLocation:
                return .coordinate(locationService.currentCoordinate!)
            default:
                return $0.weatherLocationPredicate
            }
        }
        
        weatherProvider.queryWeather(for: locationPredicates) { [userCitiesProvider] (results) in
            DispatchQueue.main.async {
                assert(userCities.count == results.count)
                (0..<results.count).forEach {
                    let userCity = userCities[$0]
                    let weatherQueryResult = results[$0]
                    try! userCitiesProvider.setWeatherQueryCompleted(for: userCity, with: weatherQueryResult)
                }
            }
        }
    }
    
    // MARK: -
    
    let userCitiesProvider: UserCitiesProvider
    let weatherProvider: WeatherProvider
    let locationService: LocationService
    
    init(userCitiesProvider: UserCitiesProvider, weatherProvider: WeatherProvider, locationService: LocationService) {
        self.userCitiesProvider = userCitiesProvider
        self.weatherProvider = weatherProvider
        self.locationService = locationService
    }
    
    deinit {()}
}
