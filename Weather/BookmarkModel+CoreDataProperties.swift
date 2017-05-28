//
//  BookmarkModel+CoreDataProperties.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreData


extension BookmarkModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookmarkModel> {
        return NSFetchRequest<BookmarkModel>(entityName: "Bookmark")
    }

    @NSManaged public var cityId: Int16
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?

}
