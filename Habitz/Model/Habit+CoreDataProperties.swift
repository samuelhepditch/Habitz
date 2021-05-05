//
//  Habit+CoreDataProperties.swift
//  Habitz
//
//  Created by Sam on 2021-05-05.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var category: String?
    @NSManaged public var colour: String?
    @NSManaged public var cycles: String?
    @NSManaged public var motivation: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var progress: [[Double]]?

}

extension Habit : Identifiable {

}
