//
//  WeatherError.swift
//  Weather
//
//  Created by Boran ASLAN on 14/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

enum WeatherError: String, Error {
    case networkError = "We lost communication."
    case requestError = "We're facing a network error."
    case dataError = "It seems there is a problem with data."
    case JSONResponseError = "We got Unidentified JSON Objects from server."
    case JSONParseError = "There is something unexpected happened."
}

