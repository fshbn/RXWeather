//
//  CityViewModel.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

class CityViewModel {

    // MARK: - Properties
    let cityName: BrnObservable<String>
    let icon: BrnObservable<String>
    let temperature: BrnObservable<String>
    let precipitationProbability: BrnObservable<String>
    let humidity: BrnObservable<String>
    let windSpeed: BrnObservable<String>
    let forecasts: BrnObservable<[Forecast]>
    
    var lat: Double = 0
    var lon: Double = 0
    
    // MARK: - Services
    fileprivate var weatherService: WeatherServiceProtocol
    
    // MARK: - init
    init(weather: Weather) {
        cityName = BrnObservable(weather.cityName)
        icon = BrnObservable(weather.icon)
        temperature = BrnObservable(String(format: "%.0f", weather.temperature) + "°")
        precipitationProbability = BrnObservable(String(format: "%.0f", weather.precipitationProbability))
        humidity = BrnObservable(String(format: "%.0f", weather.humidity))
        windSpeed = BrnObservable(String(format: "%.0f", weather.windSpeed))
        forecasts = BrnObservable([])
        
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
