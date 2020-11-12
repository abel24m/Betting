//
//  Model+CoreDataProperties.swift
//  Locks
//
//  Created by Abel Moreno on 11/12/20.
//  Copyright © 2020 Abel Moreno. All rights reserved.
//
//

import Foundation
import CoreData


extension Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model> {
        return NSFetchRequest<Model>(entityName: "Model")
    }

    @NSManaged public var league: String?
    @NSManaged public var name: String?
    @NSManaged public var stats: [String : String]?

}

extension Model : Identifiable {

}
