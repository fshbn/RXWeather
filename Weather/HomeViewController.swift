//
//  HomeViewController.swift
//  Weather
//
//  Created by Boran ASLAN on 12/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class HomeViewController: BaseViewController, UITableViewDelegate {

    // MARK: - Outlets

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!

    override func initDependencies() {
        super.initDependencies()

        presenter = initPresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.startLocationService()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Observe

    override func bindView() {
        super.bindView()

        _ = compositeDisposable.insert(presenter.cityName
            .asObservable()
            .bind(to: locationLabel.rx.text))
        _ = compositeDisposable.insert(presenter.icon
            .asObservable()
            .bind(to: iconLabel.rx.text))
        _ = compositeDisposable.insert(presenter.temperature
            .asObservable()
            .bind(to: temperatureLabel.rx.text))
        _ = compositeDisposable.insert(presenter.bookmarkedLocations
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: BookmarkTableViewCell.identifier, cellType: BookmarkTableViewCell.self)) { (_, element: Weather, cell) in
                cell.nameLabel.text = element.cityName
                cell.temperatureLabel.text = String(format: "%.0f", element.temperature) + "°"
                cell.iconLabel.text = element.icon
            }
        )
    }
}

// MARK: - Extensions

extension HomeViewController {

    var presenter: HomePresenter {
        set {
            basePresenter = newValue
        }
        get {
            if let presenter = basePresenter as? HomePresenter {
                return presenter
            }
            return initPresenter()
        }
    }

    fileprivate func initPresenter() -> HomePresenter {
        let interactor = HomeInteractor(networkService: NetworkService.sharedInstance, coreDataService: CoreDataService.sharedInstance)
        return HomePresenter(interactor: interactor, locationService: LocationService())
    }
}
