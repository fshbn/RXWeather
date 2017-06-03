//
//  BaseInteractor.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class BaseInteractor {

    internal var coreDataService: CoreDataServiceProtocol?
    internal var networkService: NetworkServiceProtocol?

    init() {
    }
}
