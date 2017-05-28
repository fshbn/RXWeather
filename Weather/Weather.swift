//
//  Weather.swift
//  Weather
//
//  Created by Boran ASLAN on 12/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

struct Weather {
    var cityId: Int16 = 0
    var cityName: String = ""
    var temperature: Double = 0
    var weatherCondition: String = ""
    var humidity: Double = 0
    var precipitationProbability: Double = 0
    var windSpeed: Double = 0
    var windDeg: Double = 0
    var icon: String = ""
    var lat: Double = 0
    var lon: Double = 0
}

extension Weather {
    
    struct Key {
        static let cityId = "id"
        static let cityName = "name"
        // main
        static let mainKey = "main"
        static let temperature = "temp"
        static let humidity = "humidity"
        
        // rain
        static let rainKey = "rain"
        static let precipitation = "3h"
        
        // wind
        static let windKey = "wind"
        static let windSpeed = "speed"
        static let windDeg = "deg"
        
        // weather[0]
        static let weatherKey = "weather"
        static let icon = "icon"
        static let weatherCondition = "main"
        
    }
    
    init?(json: [String: Any]) {
        if let cityId = json["id"] as? Int16 {
            self.cityId = cityId
        }
        
        if let cityNameString = json[Key.cityName] as? String {
            self.cityName = cityNameString
        }
        
        if let main = json[Key.mainKey] as? Dictionary<String, AnyObject> {
            if let temperatureValue = main[Key.temperature] as? Double {
                self.temperature = temperatureValue
            }
            
            if let humidityValue = main[Key.humidity] as? Double {
                self.humidity = humidityValue
            }
        }
        
        if let rain = json[Key.rainKey] as? Dictionary<String, AnyObject> {
            if let precipitationValue = rain[Key.precipitation] as? Double {
                self.precipitationProbability = precipitationValue
            }
        }
        
        if let wind = json[Key.windKey] as? Dictionary<String, AnyObject> {
            if let windSpeedValue = wind[Key.windSpeed] as? Double {
                self.windSpeed = windSpeedValue
            }
            
            if let windDegValue = wind[Key.windDeg] as? Double {
                self.windDeg = windDegValue
            }
        }
        
        if let weather = json[Key.weatherKey] as? [Dictionary<String, AnyObject>] {
            if let weatherConditionValue = weather[0][Key.weatherCondition] as? String {
                self.weatherCondition = weatherConditionValue
            }
            
            if let icon = weather[0]["icon"] as? String, let iconId = weather[0]["id"] as? Int {
                self.icon = WeatherIcon(condition: iconId, iconString: icon).iconText
            }
        }
    }
    
}

