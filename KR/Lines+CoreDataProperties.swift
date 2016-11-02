//
//  Lines+CoreDataProperties.swift
//  KR
//
//  Created by Christopher Afonso on 11/1/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import Foundation
import CoreData


extension Lines {

    @nonobjc public override class func fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Lines");
    }

    @NSManaged public var line1: String?
    @NSManaged public var line2: String?

}
