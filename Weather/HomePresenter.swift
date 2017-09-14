//
//  HomePresenter.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class HomePresenter: BasePresenter {

    // MARK: - Observable Variables

    let cityName = BehaviorSubject<String>.init(value: "")
    let icon = BehaviorSubject<String>.init(value: "")
    let temperature = BehaviorSubject<String>.init(value: "")
    let bookmarkedLocations = BehaviorSubject<[WeatherModel]>.init(value: [WeatherModel]())

    // MARK: - Properties

    fileprivate var userLastLocation = CLLocation(latitude: 0, longitude: 0)
    fileprivate var bookmarks = [WeatherModel]()

    // MARK: - Dependencies

    fileprivate var interactor: HomeInteractorProtocol
    fileprivate var locationService: LocationService

    // MARK: - Initialization

    init(interactor: HomeInteractorProtocol, locationService: LocationService) {
        self.interactor = interactor
        self.locationService = locationService

        super.init()
    }

    // MARK: - Lifecycle

    func startLocationService() {
        locationService.delegate = self
        locationService.requestLocation()
    }

    func deleteBookmark(weatherModel: WeatherModel) {
        interactor.deleteBookmark(weatherModel: weatherModel)
        bookmarks = bookmarks.filter { $0.cityId != weatherModel.cityId }

        bookmarkedLocations.onNext(bookmarks)
    }

    override func subscribe() {
        super.subscribe()

        _ = compositeDisposable.insert(observeBookmarks())
    }

    // MARK: - Observables

    func observeBookmarks() -> Disposable {
        return interactor.getBookmarks(predicate: nil)
            .subscribe(onNext: { result in
                switch result {
                case let .success(weatherModelList):
                    self.bookmarkedLocations.onNext(weatherModelList)
                    print("")
                case let .failure(error):
                    self.bookmarkedLocations.onNext([])
                }
            })
    }

    // MARK: - Business

    fileprivate func updateWeather(_ weatherModel: WeatherModel?) {
        guard let weather = weatherModel else {
            cityName.onNext("")
            icon.onNext("")
            temperature.onNext(String(format: "%.0f", "") + "°")
            return
        }
        cityName.onNext(weather.cityName)
        icon.onNext(weather.icon)
        temperature.onNext(String(format: "%.0f", weather.temperature) + "°")
    }
}

// MARK: - Extensions

// MARK: LocationServiceDelegate

extension HomePresenter: LocationServiceDelegate {

    func locationDidUpdate(_: LocationService, location: CLLocation) {
        userLastLocation = location

        //        _ = compositeDisposable.insert(interactor.getWeatherInfo(location: location)
        //            .subscribe(onNext: { result in
        //                switch result {
        //                case let .success(weather):
        //                    self.updateWeather(weather)
        //                case let .failure(error):
        //                    print(error)
        //                    self.updateWeather(nil)
        //                }
        //        }))
    }
}
