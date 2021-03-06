//
//  CityQueryingImpContainer.swift
//  OpenWeatherMapKit/CityQueryingImp
//
//  Created by Grigory Entin on 05/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

extension CityQueryingImp_CityListJson$ {
    
    static var container = Container().then {
        $0.register(CityQuerying.self) { _ in
            CityListJsonCityQuerying()
        }
    }
}
extension CityQueryingImp_CoreData$ {
    
    static var container = Container().then {
        $0.register(CityQuerying.self) { _ in
            CoreDataCityQuerying()
        }
    }
}

extension CityQueryingImp$ /* *** AUTOGENERATED *** */ {
    static var container: Container {
        return CityQueryingImp_CoreData$.container
    }
}
