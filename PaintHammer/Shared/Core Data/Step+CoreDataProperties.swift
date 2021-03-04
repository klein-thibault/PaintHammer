//
//  Step+CoreDataProperties.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var name: String?
    @NSManaged public var paint: Paint?
    @NSManaged public var project: Project?

}

extension Step : Identifiable {

}
