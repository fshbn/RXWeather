//
//  LocalStorageProtocol.swift
//  Weather
//
//  Created by Boran ASLAN on 21/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

protocol CoreDataServiceProtocol {
    func getBookmarks(predicate: NSPredicate?) -> [Bookmark]
    func saveBookmark(coordinate: CLLocationCoordinate2D) -> Bookmark?
    func update() -> Bool
    func delete(managedObject: NSManagedObject) -> Bool
}
