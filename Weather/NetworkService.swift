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
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class NetworkService: NetworkServiceProtocol {

    static let sharedInstance = NetworkService()
    let sessionManager = SessionManager.default

    private init() {
    }

    //    fileprivate func generateRequestURL(_ location: CLLocation, requestType: Constants) -> URL? {
    //        guard var components = URLComponents(string: Constants.baseURL.rawValue) else {
    //            return nil
    //        }
    //
    //        let latitude = String(location.coordinate.latitude)
    //        let longitude = String(location.coordinate.longitude)
    //
    //        components.path = "/data/2.5/" + requestType.rawValue
    //
    //        components.queryItems = [
    //            URLQueryItem(name: "lat", value: latitude),
    //            URLQueryItem(name: "lon", value: longitude),
    //            URLQueryItem(name: "appid", value: Constants.apiKey.rawValue),
    //            URLQueryItem(name: "units", value: Constants.unit.rawValue),
    //        ]
    //
    //        return components.url
    //    }

    fileprivate func generateUrlComponents(_ requestType: Constants) -> URLComponents {
        var components = URLComponents(string: Constants.baseURL.rawValue)
        components!.path = "/data/2.5/" + requestType.rawValue
        components!.queryItems = [
            URLQueryItem(name: "appid", value: Constants.apiKey.rawValue),
            URLQueryItem(name: "units", value: Constants.unit.rawValue),
        ]

        return components!
    }

    func getWeatherInfo(_ location: CLLocation) -> Observable<Any> {
        var components = generateUrlComponents(Constants.weather)
        var queryItems = components.queryItems
        queryItems?.append(URLQueryItem(name: "lat", value: String(location.coordinate.latitude)))
        queryItems?.append(URLQueryItem(name: "lon", value: String(location.coordinate.longitude)))

        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }

    func get5DayWeatherForecast(_ location: CLLocation) -> Observable<Any> {
        var components = generateUrlComponents(Constants.forecast)
        var queryItems = components.queryItems
        queryItems?.append(URLQueryItem(name: "lat", value: String(location.coordinate.latitude)))
        queryItems?.append(URLQueryItem(name: "lon", value: String(location.coordinate.longitude)))
        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }

    func getWeatherInfoList(cityIds: [Int16]) -> Observable<Any> {
        var components = generateUrlComponents(Constants.group)
        var queryItems = components.queryItems

        let ids = cityIds.reduce("") { (result, cityId) -> String in
            result + (result.characters.count > 0 ? "," : "") + String(cityId)
        }
        queryItems?.append(URLQueryItem(name: "id", value: ids))
        components.queryItems = queryItems

        return sessionManager.rx.json(.get, components.url!)
    }
}

fileprivate enum Constants: String {

    case baseURL = "http://api.openweathermap.org"
    case apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    case unit = "metric"

    case weather
    case forecast
    case group
}
