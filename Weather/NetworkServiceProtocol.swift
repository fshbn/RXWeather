//
//  NetworkServiceProtocol.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 01/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

protocol NetworkServiceProtocol {
    func getWeatherInfo(_ location: CLLocation) -> Observable<Any>
    func get5DayWeatherForecast(_ location: CLLocation) -> Observable<Any>
    func getWeatherInfoList(cityIds: [Int16]) -> Observable<Any>
}
