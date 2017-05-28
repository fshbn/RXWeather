//
//  ServiceProtocol.swift
//  Weather
//
//  Created by Boran ASLAN on 12/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

typealias CompletionHandler = (Weather?, WeatherError?) -> Void
typealias ForecastsCompletionHandler = ([Forecast]?, WeatherError?) -> Void

protocol WeatherServiceProtocol {
    func getWeatherInfo(_ location: CLLocation, completionHandler: @escaping CompletionHandler)
    func get5DayWeatherForecast(_ location: CLLocation, completionHandler: @escaping ForecastsCompletionHandler)
}

