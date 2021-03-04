//
//  Paint+CoreDataProperties.swift
//  PaintHammer
//
//  Created by Thibault Klein on 3/3/21.
//
//

import CoreData
import Foundation
import Models

extension Paint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Paint> {
        return NSFetchRequest<Paint>(entityName: "Paint")
    }

    @NSManaged public var brand: String?
    @NSManaged public var colorHexValue: String?
    @NSManaged public var name: String?
    @NSManaged public var step: Step?

    public var brandWrapped: String {
        return brand ?? ""
    }
    public var colorWrapped: PHColor {
        return PHColor(hex: colorHexValue!)!
    }
    public var nameWrapped: String {
        return name ?? ""
    }
}

extension Paint : Identifiable {

}
