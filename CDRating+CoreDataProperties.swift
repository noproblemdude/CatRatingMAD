//
//  CDRating+CoreDataProperties.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//
//

import Foundation
import CoreData


extension CDRating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRating> {
        return NSFetchRequest<CDRating>(entityName: "CDRating")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?

}

extension CDRating : Identifiable {

}
