//
//  NSManagedObjectContext+Rx.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 30/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation
import CoreData
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

extension NSManagedObjectContext {

    func insertNewEntity(entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: self)
    }

    func getObjectsForEntity(entityName: String, sortArray: [String: Bool]?) throws -> [AnyObject]? {
        return try searchObjectsForEntity(entityName: entityName, predicate: nil, sortArray: sortArray)
    }

    func searchObjectsForEntity(entityName: String, predicate: NSPredicate?, sortArray: [String: Bool]?) throws -> [AnyObject]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }

        if let sortArray = sortArray {
            var sortDescriptorArray = [NSSortDescriptor]()
            for (key, value) in sortArray {
                sortDescriptorArray.append(NSSortDescriptor(key: key, ascending: value))
            }
            fetchRequest.sortDescriptors = sortDescriptorArray
        }

        return try fetch(fetchRequest)
    }

    func countForEntity(entityName: String) throws -> Int {
        return try countForEntity(entityName: entityName, predicate: nil)
    }

    func countForEntity(entityName: String, predicate: NSPredicate?) throws -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.includesPropertyValues = false

        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }

        return try count(for: fetchRequest)
    }

    func deleteObjectForEntity(managedObject: NSManagedObject) -> Bool {
        delete(managedObject)
        return true
    }

    func deleteLastObjectsForEntity(entityName: String) throws -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.includesPropertyValues = false

        do {
            let fetchResultArray = try fetch(fetchRequest)
            guard let lastResult = fetchResultArray.last as? NSManagedObject else {
                return false
            }
            delete(lastResult)
            return true
        } catch {
            return false
        }
    }

    func deleteAllObjectsForEntity(entityName: String) throws -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.includesPropertyValues = false

        do {
            let fetchResultArray = try fetch(fetchRequest)
            guard let resultArray = fetchResultArray as? [NSManagedObject] else {
                return false
            }
            resultArray.forEach { delete($0) }
            return true
        } catch {
            return false
        }
    }
}

extension Reactive where Base: NSManagedObjectContext {
}
