//
//  CityViewController.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class CityViewController: BaseViewController {

    // MARK: - Intents

    var weather: Weather!

    // MARK: - Outlets

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rain3hLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func initDependencies() {
        super.initDependencies()

        presenter = initPresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setWeather(weather: weather)
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
        _ = compositeDisposable.insert(presenter.precipitationProbability
            .asObservable()
            .bind(to: rain3hLabel.rx.text))
        _ = compositeDisposable.insert(presenter.windSpeed
            .asObservable()
            .bind(to: windSpeedLabel.rx.text))
        _ = compositeDisposable
            .insert(presenter.humidity.asObservable()
                .bind(to: humidityLabel.rx.text))
        _ = compositeDisposable.insert(presenter.forecasts
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CityTableViewCell.identifier, cellType: CityTableViewCell.self)) { (row, element: Forecast, cell) in
                print(row)
                cell.nameLabel.text = element.weatherCondition
                cell.temperatureLabel.text = element.icon
            }
        )
    }

    override func subscribeViewTap() {
        super.subscribeViewTap()

        _ = compositeDisposable.insert(observeCloseButtonTap())
    }

    // MARK: - Actions

    func observeCloseButtonTap() -> Disposable {
        return closeButton.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
    }
}

// MARK: - Extensions

extension CityViewController {

    var presenter: CityPresenter {
        set {
            basePresenter = newValue
        }
        get {
            if let presenter = basePresenter as? CityPresenter {
                return presenter
            }
            return initPresenter()
        }
    }

    fileprivate func initPresenter() -> CityPresenter {
        let interactor = CityInteractor(networkService: NetworkService.sharedInstance)
        return CityPresenter(interactor: interactor)
    }
}

// extension CityViewController {
//
//    var presenter: CityPresenter {
//        set {
//            basePresenter = newValue
//        }
//        get {
//            return basePresenter as! CityPresenter
//        }
//    }
//
// }
