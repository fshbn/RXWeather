//
//  BasePresenter.swift
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

class BasePresenter {

    // MARK: - Observe

    let inProgress = Variable<Bool>.init(false)
    let showWarningAlert = PublishSubject<String>.init()
    let showSuccessAlert = PublishSubject<String>.init()
    let showSuccessAndPreviousView = PublishSubject<String>.init()
    let showSplashAlert = PublishSubject<String>.init()

    // MARK: - Properties

    let compositeDisposable = CompositeDisposable()

    // MARK: - Initialization

    init() {
    }

    // MARK: - Override Methods

    func subscribe() {
    }

    func unsubscribe() {
        compositeDisposable.dispose()
    }

    // MARK: - Business
}

// MARK: - Extensions
