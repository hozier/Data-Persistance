//
//  Lines+CoreDataClass.swift
//  KR
//
//  Created by Christopher Afonso on 11/1/16.
//  Copyright © 2016 Philron William Hozier. All rights reserved.
//

import Foundation
import CoreData

@objc(Lines)
public class Lines: NSManagedObject {

    @NSManaged public var line1: String?
    @NSManaged public var line2: String?
}


