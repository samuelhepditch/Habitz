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
    @NSManaged public var blocks: [[Double]]?
    @NSManaged public var notes: String?
    @NSManaged public var colour: String?

    public var wrappedName: String {
        name ?? ""
    }
    public var wrappedMotivation: String {
        motivation ?? ""
    }
    public var wrappedCategory: String {
        category ?? ""
    }
    public var wrappedBlocks: [[Double]] {
        blocks ?? [[]]
    }
    public var wrappedNotes: String {
        notes ?? ""
    }
    public var wrappedColour: String {
        colour ?? ""
    }
}

extension Habit : Identifiable {

}
