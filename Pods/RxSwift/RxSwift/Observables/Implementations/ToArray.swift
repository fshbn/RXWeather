//
//  ToArray.swift
//  RxSwift
//
//  Created by Junior B. on 20/10/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

final class ToArraySink<SourceType, O: ObserverType>: Sink<O>, ObserverType where O.E == [SourceType] {
    typealias Parent = ToArray<SourceType>

    let _parent: Parent
    var _list = Array<SourceType>()

    init(parent: Parent, observer: O, cancel: Cancelable) {
        _parent = parent

        super.init(observer: observer, cancel: cancel)
    }

    func on(_ event: Event<SourceType>) {
        switch event {
        case let .next(value):
            _list.append(value)
        case let .error(e):
            forwardOn(.error(e))
            dispose()
        case .completed:
            forwardOn(.next(_list))
            forwardOn(.completed)
            dispose()
        }
    }
}

final class ToArray<SourceType>: Producer<[SourceType]> {
    let _source: Observable<SourceType>

    init(source: Observable<SourceType>) {
        _source = source
    }

    override func run<O: ObserverType>(_ observer: O, cancel: Cancelable) -> (sink: Disposable, subscription: Disposable) where O.E == [SourceType] {
        let sink = ToArraySink(parent: self, observer: observer, cancel: cancel)
        let subscription = _source.subscribe(sink)
        return (sink: sink, subscription: subscription)
    }
}
