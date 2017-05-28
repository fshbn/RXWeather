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

class CoreDataService: LocalDataProtocol {
    
    static let sharedInstance = CoreDataService()
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getBookmarks(predicate: NSPredicate?, completionHandler: @escaping BookmarksCompletionHandler) {
        let bookmarkFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookmark")
        if let predicate = predicate {
            bookmarkFetch.predicate = predicate
        }
        
        do {
            let fetchedBookmarks = try persistentContainer.viewContext.fetch(bookmarkFetch) as! [BookmarkModel]
            completionHandler(fetchedBookmarks, nil)
        } catch {
            completionHandler(nil, WeatherError.dataError)
        }
    }
    
    func saveBookmark(coordinate: CLLocationCoordinate2D, completionHandler: @escaping BookmarksCompletionHandler) {
        let bookmark = NSEntityDescription.insertNewObject(forEntityName: "Bookmark", into: persistentContainer.viewContext) as! BookmarkModel
        bookmark.lat = coordinate.latitude
        bookmark.lon = coordinate.longitude
        
        do {
            try persistentContainer.viewContext.save()
            completionHandler(nil, nil)
        } catch {
            completionHandler(nil, WeatherError.dataError)
        }
    }
    
    func update(bookmark: BookmarkModel, completionHandler: @escaping BookmarksCompletionHandler) {
        do {
            try persistentContainer.viewContext.save()
            completionHandler(nil, nil)
        } catch {
            completionHandler(nil, WeatherError.dataError)
        }
    }
    
    func delete(bookmark: BookmarkModel, completionHandler: @escaping BookmarksCompletionHandler) {
        persistentContainer.viewContext.delete(bookmark)
        
        do {
            try persistentContainer.viewContext.save()
            completionHandler(nil, nil)
        } catch {
            completionHandler(nil, WeatherError.dataError)
        }
    }
    
}
