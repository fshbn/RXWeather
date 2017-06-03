//
//  LocalDataService.swift
//  Weather
//
//  Created by Boran ASLAN on 21/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CoreLocation
import RxCoreData
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class CoreDataService: CoreDataServiceProtocol {

    static let sharedInstance = CoreDataService()
    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func getBookmarks(predicate: NSPredicate?) -> [Bookmark] {
        do {
            guard let bookmarkList = try self.managedObjectContext.searchObjectsForEntity(entityName: Bookmark.className, predicate: predicate, sortArray: nil) as? [Bookmark] else {
                return [Bookmark]()
            }

            return bookmarkList
        } catch {}

        return [Bookmark]()
    }

    func saveBookmark(coordinate: CLLocationCoordinate2D) -> Bookmark? {
        guard let bookmark = self.managedObjectContext.insertNewEntity(entityName: Bookmark.className) as? Bookmark else {
            return nil
        }
        bookmark.lat = coordinate.latitude
        bookmark.lon = coordinate.longitude

        do {
            try managedObjectContext.save()

            return bookmark
        } catch {}

        return nil
    }

    func update() -> Bool {
        do {
            try managedObjectContext.save()

            return true
        } catch {}

        return false
    }

    func delete(managedObject _: NSManagedObject) -> Bool {
        do {
            try managedObjectContext.save()

            return true
        } catch {}

        return false
    }
}
