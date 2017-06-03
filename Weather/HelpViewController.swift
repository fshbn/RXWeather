//
//  HelpViewController.swift
//  Weather
//
//  Created by Boran ASLAN on 14/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class HelpViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var closeButton: UIButton!

    // MARK: - Initialization

    override func initDependencies() {
        super.initDependencies()

        presenter = initPresenter()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureWebView()
    }

    // MARK: - Configure

    func configureWebView() {

        if let url = Bundle.main.url(forResource: "help", withExtension: "html") {
            webView.loadRequest(URLRequest(url: url))
        }
    }

    // MARK: - Observe

    override func subscribeViewTap() {
        super.subscribeViewTap()

        _ = compositeDisposable.insert(observeCloseButtonTap())
    }

    // MARK: - Actions

    func observeCloseButtonTap() -> Disposable {
        return closeButton.rx.tap
            .asObservable()
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
    }
}

// MARK: - Extensions

extension HelpViewController {

    var presenter: HelpPresenter {
        set {
            basePresenter = newValue
        }
        get {
            if let presenter = basePresenter as? HelpPresenter {
                return presenter
            }
            return initPresenter()
        }
    }

    fileprivate func initPresenter() -> HelpPresenter {
        return HelpPresenter()
    }
}
