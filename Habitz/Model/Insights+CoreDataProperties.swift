//
//  Insights+CoreDataProperties.swift
//  Habitz
//
//  Created by Sam on 2021-05-05.
//
//

import Foundation
import CoreData


extension Insights {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insights> {
        return NSFetchRequest<Insights>(entityName: "Insights")
    }

    @NSManaged public var habitsBuilt: String?
    @NSManaged public var totalCycles: String?
    @NSManaged public var categoryArray: [Int]?

}

extension Insights : Identifiable {

}
