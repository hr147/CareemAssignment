//
//  QueryManagedObject+CoreDataProperties.swift
//  CareemAssignment
//
//  Created by Haroon Ur Rasheed on 12/15/17.
//  Copyright © 2017 Haroon Ur Rasheed. All rights reserved.
//
//

import Foundation
import CoreData


extension QueryManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QueryManagedObject> {
        return NSFetchRequest<QueryManagedObject>(entityName: "QueryManagedObject")
    }

    @NSManaged public var stamp: NSDate?
    @NSManaged public var query: String?

}
