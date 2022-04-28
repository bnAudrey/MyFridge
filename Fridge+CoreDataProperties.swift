//
//  Fridge+CoreDataProperties.swift
//  MyFridge
//
//  Created by Brigitta Audrey on 28/04/22.
//
//

import Foundation
import CoreData


extension Fridge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fridge> {
        return NSFetchRequest<Fridge>(entityName: "Fridge")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var location: String?
    @NSManaged public var total: String?
    @NSManaged public var datePicker: String?

}

extension Fridge : Identifiable {

}
