//
//  AddLocationPresenter.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

class AddLocationPresenter: BasePresenter {

    fileprivate var interactor: AddLocationInteractorProtocol

    init(interactor: AddLocationInteractorProtocol) {
        self.interactor = interactor

        super.init()
    }

    func saveBookmark(coordinate: CLLocationCoordinate2D) {
        _ = interactor.saveBookmark(coordinate: coordinate)
    }
}
