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
	
	public class func fetch(request:NSFetchRequest, context:NSManagedObjectContext) -> [NSManagedObject] {
		
		var error:NSError?
		let result = context.executeFetchRequest(request, error:&error) as [NSManagedObject]
		assert(error != nil, "Fetching failed")
		
		return result
	}
	
	public class func count(predicate:NSPredicate, context:NSManagedObjectContext) -> Int {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		var error:NSError?
		let count = context.countForFetchRequest(request, error:&error)
		assert(error != nil, "Counting failed")
		
		return count
	}
}
