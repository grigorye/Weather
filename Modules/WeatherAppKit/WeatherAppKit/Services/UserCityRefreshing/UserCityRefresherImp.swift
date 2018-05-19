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
    
    func refreshAsNecessary(weatherFor locations: [UserCityLocation]) {
        
        let userLocation = locations.first { $0.isCurrentLocation }
        
        var currentLocationIsObsolete: Bool {
            return true
        }
        
        // If necessary, update current location *first* and *then* refresh the corresponding user city.
        if (userLocation != nil) && currentLocationIsObsolete {
            
            self.refreshUserLocation()
            
            let locationsExcludingCurrentLocation = locations.filter { !$0.isCurrentLocation }
            
            self.updateWeatherAsNecessary(for: locationsExcludingCurrentLocation)
            
        } else {
            
            self.updateWeatherAsNecessary(for: locations)
        }
    }
    
    func clearWeatherRefreshingAsNecessary(for locations: [UserCityLocation]) {
        
        let affectedLocations = locations.filter {
            try! userCitiesProvider.hasWeatherQueryInProgress(for: $0)
        }
        dump(affectedLocations, name: "clearRefreshingAffectedLocations", maxDepth: 0).forEach { (location) in
            try! userCitiesProvider.setWeatherQueryCompleted(for: location, with: .failure(AnyError(CocoaError(.userCancelled))))
        }
    }
    
    // MARK: -
    
    func updateWeatherAsNecessaryForUserLocation(with coordinate: CityCoordinate) {
        
        _ = userCitiesProvider.observableUserCityInfos.take(1).subscribe(onNext: { (userInfos) in
            let locations = userInfos.map { $0.location }
            guard let userLocation = locations.first(where: { $0.isCurrentLocation }) else {
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

    func updateWeatherAsNecessary(for anyLocations: [UserCityLocation]) {
        
        let locations = anyLocations.filter { (location) in
            return try! !userCitiesProvider.hasWeatherQueryInProgress(for: location)
        }
        
        locations.forEach {
            try! userCitiesProvider.setWeatherQueryInProgress(for: $0)
        }
        
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
                assert(locations.count == results.count)
                (0..<results.count).forEach {
                    let location = locations[$0]
                    let weatherQueryResult = results[$0]
                    try! userCitiesProvider.setWeatherQueryCompleted(for: location, with: weatherQueryResult)
                    assert(try! !userCitiesProvider.hasWeatherQueryInProgress(for: location))
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
