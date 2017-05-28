//
//  LocalStorageProtocol.swift
//  Weather
//
//  Created by Boran ASLAN on 21/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreLocation

typealias BookmarksCompletionHandler = ([AnyObject]?, WeatherError?) -> Void

protocol LocalDataProtocol {
    func getBookmarks(predicate: NSPredicate?, completionHandler: @escaping BookmarksCompletionHandler)
    func saveBookmark(coordinate: CLLocationCoordinate2D, completionHandler: @escaping BookmarksCompletionHandler)
    func update(bookmark: BookmarkModel, completionHandler: @escaping BookmarksCompletionHandler)
    func delete(bookmark: BookmarkModel, completionHandler: @escaping BookmarksCompletionHandler)
}
