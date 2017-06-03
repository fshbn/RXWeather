//
//  CityPresenter.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class CityPresenter: BasePresenter {

    // MARK: - Observable Variables

    let cityName = BehaviorSubject<String>.init(value: "")
    let icon = BehaviorSubject<String>.init(value: "")
    let temperature = BehaviorSubject<String>.init(value: "")
    let precipitationProbability = BehaviorSubject<String>.init(value: "")
    let humidity = BehaviorSubject<String>.init(value: "")
    let windSpeed = BehaviorSubject<String>.init(value: "")
    let forecasts = BehaviorSubject<[Forecast]>.init(value: [])

    // MARK: - Properties

    private var weather: Weather!

    // MARK: - Dependencies

    fileprivate var interactor: CityInteractorProtocol

    // MARK: - Initialization

    init(interactor: CityInteractorProtocol) {
        self.interactor = interactor

        super.init()
    }

    func setWeather(weather: Weather) {
        self.weather = weather

        loadView()
        _ = compositeDisposable.insert(observe5DayForecast())
    }

    // MARK: - Business

    fileprivate func loadView() {
        cityName.onNext(weather.cityName)
        icon.onNext(weather.icon)
        temperature.onNext(String(format: "%.0f", weather.temperature) + "°")
        precipitationProbability.onNext(String(format: "%.0f", weather.precipitationProbability))
        humidity.onNext(String(format: "%.0f", weather.humidity))
        windSpeed.onNext(String(format: "%.0f", weather.windSpeed))
    }

    // MARK: - Observables

    fileprivate func observe5DayForecast() -> Disposable {
        let location = CLLocation(latitude: weather.lat, longitude: weather.lon)

        return interactor.get5DayWeatherForecast(location: location)
            .subscribe(onNext: { result in
                switch result {
                case let .success(forecastList):
                    self.forecasts.onNext(forecastList)
                case let .failure(weatherError):
                    self.showWarningAlert.onNext(weatherError.rawValue)
                }
            })
    }
}
