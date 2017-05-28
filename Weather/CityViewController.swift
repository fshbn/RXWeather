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

class CityViewController: UIViewController {
    
    var viewModel: CityViewModel?
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rain3hLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewController()
    }
    
    fileprivate func observeViewController() {
        viewModel?.cityName.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.locationLabel.text = $0
            })
            .addDisposableTo(disposeBag)
        
        viewModel?.icon.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.iconLabel.text = $0
            })
            .addDisposableTo(disposeBag)
        
        viewModel?.temperature.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.temperatureLabel.text = $0
            })
            .addDisposableTo(disposeBag)
        
        viewModel?.precipitationProbability.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.rain3hLabel.text = $0
            })
            .addDisposableTo(disposeBag)
        
        viewModel?.windSpeed.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.windSpeedLabel.text = $0
            })
            .addDisposableTo(disposeBag)
        
        viewModel?.humidity.asObservable()
            .subscribe(onNext: {
                [unowned self] in
                self.humidityLabel.text = $0
            })
            .addDisposableTo(disposeBag)
    }
    
    func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeView()
    }
}
