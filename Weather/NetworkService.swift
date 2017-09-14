//
//  NetworkService.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 01/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import RxAlamofire
import RxSwift
import RxCocoa

fileprivate enum NetworkConstants: String {

    case baseURL = "http://api.openweathermap.org"
    case apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    case unit = "metric"

    case weather
    case forecast
    case group
}

class NetworkService: NetworkServiceProtocol {

    static let sharedInstance = NetworkService()
    let sessionManager = SessionManager.default

    private init() {}

    fileprivate func generateUrlComponents(_ requestType: NetworkConstants) -> URLComponents {
        var components = URLComponents(string: NetworkConstants.baseURL.rawValue)
        components!.path = "/data/2.5/" + requestType.rawValue
        components!.queryItems = [
            URLQueryItem(name: "appid", value: NetworkConstants.apiKey.rawValue),
            URLQueryItem(name: "units", value: NetworkConstants.unit.rawValue),
        ]

        return components!
    }

    func getWeatherInfo(_ location: CLLocation) -> Observable<Any> {
        var components = generateUrlComponents(NetworkConstants.weather)
        var queryItems = components.queryItems
        queryItems?.append(URLQueryItem(name: "lat", value: String(location.coordinate.latitude)))
        queryItems?.append(URLQueryItem(name: "lon", value: String(location.coordinate.longitude)))

        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }

    func get5DayWeatherForecast(_ location: CLLocation) -> Observable<Any> {
        var components = generateUrlComponents(NetworkConstants.forecast)
        var queryItems = components.queryItems
        queryItems?.append(URLQueryItem(name: "lat", value: String(location.coordinate.latitude)))
        queryItems?.append(URLQueryItem(name: "lon", value: String(location.coordinate.longitude)))
        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }

    func getWeatherInfoList(cityIds: [Int16]) -> Observable<Any> {
        var components = generateUrlComponents(NetworkConstants.group)
        var queryItems = components.queryItems

        let ids = cityIds.reduce("") { (result, cityId) -> String in
            result + (result.characters.count > 0 ? "," : "") + String(cityId)
        }
        queryItems?.append(URLQueryItem(name: "id", value: ids))
        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }
}
