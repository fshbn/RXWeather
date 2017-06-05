//
//  CityPresenter.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class CityPresenter: BasePresenter {

    // MARK: - Observable Variables

    let cityName = BehaviorSubject<String>.init(value: "")
    let icon = BehaviorSubject<String>.init(value: "")
    let temperature = BehaviorSubject<String>.init(value: "")
    let precipitationProbability = BehaviorSubject<String>.init(value: "")
    let humidity = BehaviorSubject<String>.init(value: "")
    let windSpeed = BehaviorSubject<String>.init(value: "")
    let forecasts = BehaviorSubject<[ForecastModel]>.init(value: [])

    // MARK: - Properties

    private var weatherModel: WeatherModel!

    // MARK: - Dependencies

    fileprivate var interactor: CityInteractorProtocol

    // MARK: - Initialization

    init(interactor: CityInteractorProtocol) {
        self.interactor = interactor

        super.init()
    }

    func setWeatherModel(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel

        loadView()
        _ = compositeDisposable.insert(observe5DayForecast())
    }

    // MARK: - Business

    fileprivate func loadView() {
        cityName.onNext(weatherModel.cityName)
        icon.onNext(weatherModel.icon)
        temperature.onNext(String(format: "%.0f", weatherModel.temperature) + "°")
        precipitationProbability.onNext(String(format: "%.0f", weatherModel.precipitationProbability))
        humidity.onNext(String(format: "%.0f", weatherModel.humidity))
        windSpeed.onNext(String(format: "%.0f", weatherModel.windSpeed))
    }

    // MARK: - Observables

    fileprivate func observe5DayForecast() -> Disposable {
        let location = CLLocation(latitude: weatherModel.lat, longitude: weatherModel.lon)

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
