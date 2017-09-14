//
//  Forecast.swift
//  Weather
//
//  Created by Boran ASLAN on 12/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

struct Forecast {
    var date: Double = 0
    var temperature: Double = 0
    var weatherCondition: String = ""
    var humidity: Double = 0
    var precipitationProbability: Double = 0
    var windSpeed: Double = 0
    var windDeg: Double = 0
    var icon: String = ""
}

extension Forecast {

    struct Key {
        static let date = "dt"
        // temp
        static let tempKey = "temp"
        static let temperatureday = "day"

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
        if let dateValue = json[Key.date] as? Double {
            date = dateValue
        }

        if let main = json[Key.tempKey] as? [String: AnyObject] {
            if let temperatureValue = main[Key.temperatureday] as? Double {
                temperature = temperatureValue
            }

            if let humidityValue = main[Key.humidity] as? Double {
                humidity = humidityValue
            }
        }

        if let weather = json[Key.weatherKey] as? [[String: AnyObject]] {
            if let weatherConditionValue = weather[0][Key.weatherCondition] as? String {
                weatherCondition = weatherConditionValue
            }

            if let icon = weather[0]["icon"] as? String, let iconId = weather[0]["id"] as? Int {
                self.icon = WeatherIcon(condition: iconId, iconString: icon).iconText
            }
        }

        if let rain = json[Key.rainKey] as? [String: AnyObject] {
            if let precipitationValue = rain[Key.precipitation] as? Double {
                precipitationProbability = precipitationValue
            }
        }

        if let wind = json[Key.windKey] as? [String: AnyObject] {
            if let windSpeedValue = wind[Key.windSpeed] as? Double {
                windSpeed = windSpeedValue
            }

            if let windDegValue = wind[Key.windDeg] as? Double {
                windDeg = windDegValue
            }
        }
    }
}
