//
//  UserCityRefresherImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 15/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Dispatch

class UserCityRefresherImp : UserCityRefresher {
    
    // MARK: - <UserCityRefresher>
    
    func refreshUserCitiesAsNecessary(_ userCities: [UserCity]) {
        
        let userLocation = userCities.first { $0.location.isCurrentLocation }
        
        var currentLocationIsObosolete: Bool {
            return true
        }
        
        // If necessary, update current location *first* and *then* refresh the corresponding user city.
        if (userLocation != nil) && currentLocationIsObosolete {
            
            self.refreshUserLocation()
            
            let userCitiesWithoutCurrentLocation = userCities.filter { !$0.location.isCurrentLocation }
            
            self.updateWeatherForUserCitiesAsNecessary(userCitiesWithoutCurrentLocation)
            
        } else {
            
            self.updateWeatherForUserCitiesAsNecessary(userCities)
        }
    }
    
    // MARK: -
    
    func updateWeatherForUserLocationAsNecessary(with coordinate: CityCoordinate) {
        
        guard let userLocation = userCitiesProvider.userCities.first(where: { $0.location.isCurrentLocation }) else {
            return
        }
        self.updateWeatherForUserCitiesAsNecessary([userLocation])
    }
    
    func refreshUserLocation() {
        
        locationService.queryCurrentLocation(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let coordinate):
                self?.updateWeatherForUserLocationAsNecessary(with: coordinate)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func updateWeatherForUserCitiesAsNecessary(_ userCities: [UserCity]) {
        
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
