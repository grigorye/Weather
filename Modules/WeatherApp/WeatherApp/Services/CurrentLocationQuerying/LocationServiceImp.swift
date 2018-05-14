//
//  LocationServiceImp.swift
//  WeatherApp
//
//  Created by Grigory Entin on 14/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Result
import CoreLocation
import Foundation

class LocationServiceImp : NSObject, LocationService, CLLocationManagerDelegate {
    
    lazy var locationManager = CLLocationManager().then {
        $0.delegate = self
    }
    
    var currentQueryDate: Date!
    var completionHandler: ((Result<CityCoordinate, AnyError>) -> Void)!
    
    // MARK: - <LocationService>
    
    func queryCurrentLocation(completionHandler: @escaping (Result<CityCoordinate, AnyError>) -> Void) {
        precondition(currentQueryDate == nil)
        locationManager.requestWhenInUseAuthorization()
        
        self.currentQueryDate = Date()
        self.completionHandler = completionHandler
        locationManager.startUpdatingLocation()
    }
    
    var currentCoordinate: CityCoordinate? {
        guard let location = locationManager.location else {
            return nil
        }
        guard Date().timeIntervalSince(location.timestamp) < 600 else {
            return nil
        }
        let coordinate = location.coordinate
        return .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    var timeIntervalSinceLastUpdate: TimeInterval {
        guard let location = locationManager.location else {
            return Date().timeIntervalSince(.distantPast)
        }
        return Date().timeIntervalSince(location.timestamp)
    }
    
    // MARK: - <CLLocationManagerDelegate>
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status:", status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        assert(currentQueryDate != nil)
        
        completionHandler(.failure(AnyError(error)))
        self.currentQueryDate = nil
        self.completionHandler = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentQueryDate = currentQueryDate else {
            return
        }
        
        guard let location = locations.last else {
            return
        }
        
        guard location.timestamp > currentQueryDate else {
            return
        }
        
        assert(currentCoordinate != nil)
        
        locationManager.stopUpdatingLocation()
        
        completionHandler(.success(currentCoordinate!))
        
        self.currentQueryDate = nil
        self.completionHandler = nil
    }

}
