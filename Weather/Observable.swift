//
//  Observable.swift
//  Weather
//
//  Created by Boran ASLAN on 12/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

class BrnObservable<T> {
    typealias Observer = (T) -> Void
    var observer: Observer?

    func observe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }

    var value: T {
        didSet {
            observer?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}
