//
//  BaseInteractor.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseInteractor {

    internal var coreDataService: CoreDataServiceProtocol?
    internal var networkService: NetworkServiceProtocol?

    init() {
    }
}
