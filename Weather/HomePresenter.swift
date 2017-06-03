//
//  HomePresenter.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class HomePresenter: BasePresenter {

    // MARK: - Observable Variables

    let cityName = BehaviorSubject<String>.init(value: "")
    let icon = BehaviorSubject<String>.init(value: "")
    let temperature = BehaviorSubject<String>.init(value: "")
    let bookmarkedLocations = BehaviorSubject<[Weather]>.init(value: [Weather]())

    // MARK: - Properties

    fileprivate var userLastLocation = CLLocation(latitude: 0, longitude: 0)
    fileprivate var bookmarks = [Weather]()

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

    func deleteBookmark(weather: Weather) {
        interactor.deleteBookmark(weather: weather)
        bookmarks = bookmarks.filter { $0.cityId != weather.cityId }

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
                case let .success(weatherList):
                    self.bookmarkedLocations.onNext(weatherList)
                case let .failure(error):
                    self.bookmarkedLocations.onNext([])
                }
            })
    }

    // MARK: - Business

    fileprivate func updateWeather(_ weather: Weather?) {
        guard let weather = weather else {
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
