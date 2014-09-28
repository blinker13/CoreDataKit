//
//  Bar.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 28/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import Foundation
import CoreData

class Bar: NSManagedObject {

    @NSManaged var creationDate: NSDate
    @NSManaged var name: String

}
