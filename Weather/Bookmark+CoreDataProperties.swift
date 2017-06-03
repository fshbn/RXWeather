//
//  Bookmark+CoreDataProperties.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 30/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreData

extension Bookmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
        return NSFetchRequest<Bookmark>(entityName: "Bookmark")
    }

    @NSManaged public var cityId: Int16
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
}
