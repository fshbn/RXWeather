//
//  ObserveOnSerialDispatchQueue.swift
//  RxSwift
//
//  Created by Krunoslav Zaher on 5/31/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if TRACE_RESOURCES
    fileprivate var _numberOfSerialDispatchQueueObservables: AtomicInt = 0
    extension Resources {
        /**
         Counts number of `SerialDispatchQueueObservables`.

         Purposed for unit tests.
         */
        public static var numberOfSerialDispatchQueueObservables: Int32 {
            return _numberOfSerialDispatchQueueObservables.valueSnapshot()
        }
    }
#endif

final class ObserveOnSerialDispatchQueueSink<O: ObserverType>: ObserverBase<O.E> {
    let scheduler: SerialDispatchQueueScheduler
    let observer: O

    let cancel: Cancelable

    var cachedScheduleLambda: ((ObserveOnSerialDispatchQueueSink<O>, Event<E>) -> Disposable)!

    init(scheduler: SerialDispatchQueueScheduler, observer: O, cancel: Cancelable) {
        self.scheduler = scheduler
        self.observer = observer
        self.cancel = cancel
        super.init()

        cachedScheduleLambda = { sink, event in
            sink.observer.on(event)

            if event.isStopEvent {
                sink.dispose()
            }

            return Disposables.create()
        }
    }

    override func onCore(_ event: Event<E>) {
        _ = scheduler.schedule((self, event), action: cachedScheduleLambda)
    }

    override func dispose() {
        super.dispose()

        cancel.dispose()
    }
}

final class ObserveOnSerialDispatchQueue<E>: Producer<E> {
    let scheduler: SerialDispatchQueueScheduler
    let source: Observable<E>

    init(source: Observable<E>, scheduler: SerialDispatchQueueScheduler) {
        self.scheduler = scheduler
        self.source = source

        #if TRACE_RESOURCES
            _ = Resources.incrementTotal()
            _ = AtomicIncrement(&_numberOfSerialDispatchQueueObservables)
        #endif
    }

    override func run<O: ObserverType>(_ observer: O, cancel: Cancelable) -> (sink: Disposable, subscription: Disposable) where O.E == E {
        let sink = ObserveOnSerialDispatchQueueSink(scheduler: scheduler, observer: observer, cancel: cancel)
        let subscription = source.subscribe(sink)
        return (sink: sink, subscription: subscription)
    }

    #if TRACE_RESOURCES
        deinit {
            _ = Resources.decrementTotal()
            _ = AtomicDecrement(&_numberOfSerialDispatchQueueObservables)
        }
    #endif
}
