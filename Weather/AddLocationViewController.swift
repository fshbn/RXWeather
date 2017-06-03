//
//  AddLocationViewController.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit
import MapKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class AddLocationViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeButton: UIButton!

    // MARK: - Properties

    var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)

    // MARK: - Dependencies

    // MARK: - Init

    override func initDependencies() {
        super.initDependencies()

        presenter = initPresenter()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMapView()
    }

    // MARK: - Configure

    func configureMapView() {
        mapView.showsUserLocation = true

        let regionRadius = 100
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationOnLongPress(gesture:)))
        longPressGesture.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPressGesture)
    }

    // MARK: - Observe

    override func subscribeViewTap() {
        super.subscribeViewTap()

        _ = compositeDisposable.insert(observeCloseButtonTap())
    }

    // MARK: - Actions

    func addAnnotationOnLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)

            let alert = UIAlertController(title: "add_location_new_location_title".localized, message: "add_location_new_location_message".localized, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "no".localized, style: UIAlertActionStyle.destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "add_location_new_location_yes".localized, style: UIAlertActionStyle.default, handler: { _ in
                self.presenter.saveBookmark(coordinate: coordinate)

                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    func observeCloseButtonTap() -> Disposable {
        return closeButton.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
    }
}

// MARK: - Extensions

extension AddLocationViewController {

    var presenter: AddLocationPresenter {
        set {
            basePresenter = newValue
        }
        get {
            if let presenter = basePresenter as? AddLocationPresenter {
                return presenter
            }
            return initPresenter()
        }
    }

    fileprivate func initPresenter() -> AddLocationPresenter {
        let interactor = AddLocationInteractor(coreDataService: CoreDataService.sharedInstance)
        return AddLocationPresenter(interactor: interactor)
    }
}
