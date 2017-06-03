//
//  Enums.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 01/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case success(T)
    case failure(WeatherError)
}
