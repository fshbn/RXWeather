//
//  AddLocationInteractor.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

protocol AddLocationInteractorProtocol {
    func saveBookmark(coordinate: CLLocationCoordinate2D) -> Bookmark?
}

class AddLocationInteractor: BaseInteractor, AddLocationInteractorProtocol {

    init(coreDataService: CoreDataServiceProtocol) {
        super.init()

        self.coreDataService = coreDataService
    }

    func saveBookmark(coordinate: CLLocationCoordinate2D) -> Bookmark? {
        return coreDataService!.saveBookmark(coordinate: coordinate)
    }
}
