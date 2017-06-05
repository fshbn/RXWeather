//
//  HomeInteractor.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
import RxSwift
import RxCocoa

protocol HomeInteractorProtocol {
    func getWeatherInfo(location: CLLocation) -> Observable<ServiceResult<WeatherModel>>
    func getBookmarks(predicate: NSPredicate?) -> Observable<ServiceResult<[WeatherModel]>>
    func deleteBookmark(weatherModel: WeatherModel)
}

class HomeInteractor: BaseInteractor, HomeInteractorProtocol {

    // MARK: - Services

    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        super.init()

        self.networkService = networkService
        self.coreDataService = coreDataService
    }

    func deleteBookmark(weatherModel: WeatherModel) {
        let predicate = NSPredicate(format: "cityId == %@", weatherModel.cityId)
        let bookmarkList = coreDataService?.getBookmarks(predicate: predicate)

        bookmarkList?.forEach { _ = self.coreDataService?.delete(managedObject: $0) }
    }

    func getBookmarks(predicate: NSPredicate? = nil) -> Observable<ServiceResult<[WeatherModel]>> {
        return Observable.create({ (observer) -> Disposable in
            let bookmarkList = self.coreDataService?.getBookmarks(predicate: predicate)
            let cityIds = bookmarkList?.map { $0.cityId }
            return self.networkService!.getWeatherInfoList(cityIds: cityIds!)
                .subscribe(onNext: { data in
                    var weatherModelList = [WeatherModel]()
                    guard let json = data as? [String: AnyObject] else {
                        observer.onNext(ServiceResult.failure(WeatherError.dataError))
                        return
                    }
                    print(json)

                    // TODO: Parse JSON

                    observer.onNext(ServiceResult.success(weatherModelList))
                    observer.onCompleted()
                }, onError: { error in
                    print(error)
                    observer.onNext(ServiceResult.failure(WeatherError.dataError))
                    observer.onCompleted()
                })
        })
    }

    func getWeatherInfo(location: CLLocation) -> Observable<ServiceResult<WeatherModel>> {
        return Observable.create({ (observer) -> Disposable in
            self.networkService!.getWeatherInfo(location)
                .subscribe(onNext: { data in
                    guard let json = data as? [String: AnyObject], json["id"] != nil else {
                        observer.onNext(ServiceResult.failure(WeatherError.dataError))
                        return
                    }
                    print(json)

                    // TODO: Parse JSON

                    observer.onNext(ServiceResult.success(WeatherModel(json: json)!))
                    observer.onCompleted()
                }, onError: { error in
                    print(error)
                    observer.onCompleted()
                })
        })
    }

    //
    //    func getWeatherInfo(bookmarkList: [Bookmark], index: Int, completionHandler: @escaping () -> Void) {
    //        let location = CLLocation(latitude: bookmarkList[index].lat, longitude: bookmarkList[index].lon)
    //        networkService!.getWeatherInfo(location)
    //            .subscribe(onNext: { data in
    //                guard let json = data as? [String: AnyObject], json["id"] != nil else {
    //                    if bookmarkList.count - 1 == index {
    //                        completionHandler()
    //                    } else {
    //                        self.getWeatherInfo(bookmarkList: bookmarkList, index: index + 1, completionHandler: completionHandler)
    //                    }
    //                    return
    //                }
    //                print(json)
    //                if bookmarkList.count - 1 == index {
    //                    self.weatherList.append(Weather(json: json)!)
    //                    completionHandler()
    //                } else {
    //                    self.getWeatherInfo(bookmarkList: bookmarkList, index: index + 1, completionHandler: completionHandler)
    //                }
    //            }, onError: { error in
    //                print(error)
    //                if bookmarkList.count - 1 == index {
    //                    completionHandler()
    //                } else {
    //                    self.getWeatherInfo(bookmarkList: bookmarkList, index: index + 1, completionHandler: completionHandler)
    //                }
    //            }).dispose()
    //    }

    //    func getWeatherInfo(_ bookmark: Bookmark, isCompleted: Bool) -> Observable<ServiceResult<Weather>> {
    //        let location = CLLocation(latitude: bookmark.lat, longitude: bookmark.lon)
    //        return Observable.create({ (observer) -> Disposable in
    //            self.networkService!.getWeatherInfo(location)
    //                .subscribe(onNext: { data in
    //                    guard let json = data as? [String: AnyObject], json["id"] != nil else {
    //                        observer.onNext(ServiceResult.failure(WeatherError.dataError))
    //                        return
    //                    }
    //                    print(json)
    //
    //                    observer.onNext(ServiceResult.success(Weather(json: json)!))
    //                    if isCompleted {
    //                        observer.onCompleted()
    //                    }
    //                }, onError: { error in
    //                    print(error)
    //                    if isCompleted {
    //                        observer.onCompleted()
    //                    }
    //                })
    //        })
    //    }
    //
    //    private func getWeatherInfo(bookmark: Bookmark?) -> Observable<ServiceResult<Weather>> {
    //        var location = CLLocation(latitude: 13.12321, longitude: 12.12414)
    //        if let b = bookmark {
    //            location = CLLocation(latitude: b.lat, longitude: b.lon)
    //        }
    //        return Observable.create({ (observer) -> Disposable in
    //            self.networkService!.getWeatherInfo(location)
    //                .subscribe(onNext: { data in
    //                    guard let json = data as? [String: AnyObject], json["id"] != nil else {
    //                        observer.onNext(ServiceResult.failure(WeatherError.dataError))
    //                        return
    //                    }
    //                    print(json)
    //
    //                    observer.onNext(ServiceResult.success(Weather(json: json)!))
    //                    observer.onCompleted()
    //                }, onError: { error in
    //                    print(error)
    //                    observer.onCompleted()
    //                })
    //        })
    //    }
}
