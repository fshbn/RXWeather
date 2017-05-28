//
//  AddLocationViewModel.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class AddLocationViewModel {
    
     fileprivate var localDataService: LocalDataProtocol
    
    // MARK: - init
    init() {
        localDataService = CoreDataService.sharedInstance
    }
    
    // MARK: - public
    func saveBookmark(coordinate: CLLocationCoordinate2D) {
        localDataService.saveBookmark(coordinate: coordinate) { (result, error) in
            
        }
    }
}

