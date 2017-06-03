//
//  BaseViewController.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 29/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class BaseViewController: UIViewController {

    let compositeDisposable = CompositeDisposable()
    open var basePresenter: BasePresenter!

    // MARK: - Initialization

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        initDependencies()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initDependencies()
    }

    func initDependencies() {}

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeViewTap()
        bindView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        basePresenter.subscribe()
        subscribePresenter()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        basePresenter.unsubscribe()
        compositeDisposable.dispose()
    }

    // MARK: - Reactive

    func subscribePresenter() {}

    func bindView() {}

    func subscribeViewTap() {}
}
