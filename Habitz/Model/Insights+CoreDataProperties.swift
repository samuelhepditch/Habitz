//
//  Insights+CoreDataProperties.swift
//  Habitz
//
//  Created by Sam on 2021-05-05.
//

import Foundation
import CoreData

extension Insights {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insights> {
        return NSFetchRequest<Insights>(entityName: "Habit")
    }

    @NSManaged public var habitsBuilt: String?

}

extension Insights : Identifiable {

}
