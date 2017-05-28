//
//  CityViewModel.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation


#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class CityViewModel {

    // MARK: - Properties
    let cityName: Variable<String> = Variable(emptyString)
    let icon: Variable<String> = Variable(emptyString)
    let temperature: Variable<String> = Variable(emptyString)
    let precipitationProbability: Variable<String> = Variable(emptyString)
    let humidity: Variable<String> = Variable(emptyString)
    let windSpeed: Variable<String> = Variable(emptyString)
    let forecasts: Variable<[Forecast]> = Variable([])
    
    var lat: Double = 0
    var lon: Double = 0
    
    // MARK: - Services
    fileprivate var weatherService: WeatherServiceProtocol
    
    // MARK: - init
    init(weather: Weather) {
        cityName.value = weather.cityName
        icon.value = weather.icon
        temperature.value = String(format: "%.0f", weather.temperature) + "°"
        precipitationProbability.value = String(format: "%.0f", weather.precipitationProbability)
        humidity.value = String(format: "%.0f", weather.humidity)
        windSpeed.value = String(format: "%.0f", weather.windSpeed)
        forecasts.value = []
        
        lat = weather.lat
        lon = weather.lon
        
        weatherService = OpenWeatherMapService()
        self.get5DayForecast()
    }
    
    fileprivate func get5DayForecast() {
        let location = CLLocation(latitude: lat, longitude: lon)
        
        weatherService.get5DayWeatherForecast(location) { forecastList, error -> Void in
            if let unwrappedError = error {
                self.updateForecasts(unwrappedError)
                return
            }
            
            guard let unwrappedForecasts = forecastList else {
                return
            }
            
            DispatchQueue.main.async(execute: {
                self.updateForecasts(unwrappedForecasts)
            })
        }
    }
    
    // MARK: - private
    fileprivate func updateForecasts(_ forecasts: [Forecast]) {
        self.forecasts.value = forecasts
    }
    
    fileprivate func updateForecasts(_ error: WeatherError) {
        self.forecasts.value = []
    }
}
