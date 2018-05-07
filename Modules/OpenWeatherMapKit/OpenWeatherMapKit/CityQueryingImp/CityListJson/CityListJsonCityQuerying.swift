//
//  CityListJsonCityQuerying.swift
//  OpenWeatherMapKit/CityQueryingImp/CityListJson
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import GZIP
import RxSwift
import Then

func decodeCityListJson() throws -> [CityInfo] {
    let bundle: Bundle = .current
    let pathToGZ = bundle.url(forResource: "city.list.json", withExtension: "gz")!
    let dataGZ = try Data(contentsOf: pathToGZ)
    let data = (dataGZ as NSData).gunzipped()!
    let decoded = try JSONDecoder().decode([CityInfo].self, from: data)
    return decoded
}

extension Observable : Then {}

private let defaultCityInfos = Observable<[CityInfo]>.create({ observer in
    DispatchQueue.global().async {
        let decoded = try! decodeCityListJson()
        observer.on(.next(decoded))
        observer.on(.completed)
    }
    return Disposables.create()
}).share(replay: 1, scope: .forever)

extension CityQueryingImp_CityListJson$ {
    
    class CityListJsonCityQuerying : CityQuerying {
        
        init() {()}
        deinit {()}
        
        private var cityInfos = defaultCityInfos

        func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void) -> DisposableQuery {
            let disposeBag = DisposeBag()
            cityInfos
                .observeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
                .map {
                    print("Filtering \(text)")
                    return $0.filter { $0.name.contains(text) }
                }
                .observeOn(MainScheduler.asyncInstance)
                //.debug(trimOutput: true)
                .subscribe(onNext: {
                    completion(.success($0))
                })
                .disposed(by: disposeBag)
            return disposeBag
        }
    }
}

extension CityQueryingImp_CityListJson$$ /* *** AUTOGENERATED *** */ {
    typealias CityListJsonCityQuerying = CityQueryingImp_CityListJson$.CityListJsonCityQuerying
}
