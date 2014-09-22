//
//  NSManagedObject.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSManagedObject {

	public class var entityName:String {
		let name = NSStringFromClass(self)
		let nameParts = name.componentsSeparatedByString(".")
		return nameParts.last!
	}
}


public extension NSManagedObject {

	public class func insert(context:NSManagedObjectContext) -> NSManagedObject {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as NSManagedObject
	}
	
	public class func fetch(request:NSFetchRequest, _ context:NSManagedObjectContext) -> [NSManagedObject] {
		return context.executeFetchRequest(request, error:nil) as [NSManagedObject]
	}
	
	
}
