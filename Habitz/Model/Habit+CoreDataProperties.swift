//
//  Habit+CoreDataProperties.swift
//  Habitz
//
//  Created by Sam on 2021-03-27.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var name: String?
    @NSManaged public var motivation: String?
    @NSManaged public var category: String?
    @NSManaged public var progress: [[Double]]?
    @NSManaged public var notes: String?
    @NSManaged public var colour: String?
    @NSManaged public var cycles: String?

}

extension Habit : Identifiable {

}
