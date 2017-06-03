//
//  CityInteractor.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

protocol CityInteractorProtocol {
    func get5DayWeatherForecast(location: CLLocation) -> Observable<ServiceResult<[Forecast]>>
}

class CityInteractor: BaseInteractor, CityInteractorProtocol {

    init(networkService: NetworkServiceProtocol) {
        super.init()

        self.networkService = networkService
    }

    func get5DayWeatherForecast(location: CLLocation) -> Observable<ServiceResult<[Forecast]>> {
        return Observable.create({ (observer) -> Disposable in
            self.networkService!.get5DayWeatherForecast(location)
                .subscribe(onNext: { data in
                    print(data)
                    observer.onNext(ServiceResult.success([]))
                    observer.onCompleted()
                }, onError: { _ in
                    observer.onNext(ServiceResult.failure(WeatherError.dataError))
                    observer.onCompleted()
                })
        })
    }
}
