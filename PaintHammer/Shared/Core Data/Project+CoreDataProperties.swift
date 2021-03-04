//
//  Project+CoreDataProperties.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var name: String?
    @NSManaged public var steps: NSSet?

    public var nameWrapped: String {
        return name ?? ""
    }
    public var stepsArray: [Step] {
        let set = steps as? Set<Step> ?? []
        return Array(set)
    }
}

// MARK: Generated accessors for steps
extension Project {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

extension Project : Identifiable {

}
