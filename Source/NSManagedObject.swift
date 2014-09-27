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

	public class func insert(context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as NSManagedObject
	}
	
	public class func lazy(info:[String:AnyObject?], context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject {
		
		return NSManagedObject()//TODO: implementation
	}
	
	public class func fetch(request:NSFetchRequest, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		
		var error:NSError?
		let result = context.executeFetchRequest(request, error:&error) as [NSManagedObject]
		assert(error != nil, "Fetching failed")
		
		return result
	}
	
	public class func fetch(predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		return self.fetch(request, context:context)
	}
	
	public class func first(predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject? {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		request.fetchLimit = 1
		
		let results = self.fetch(request, context:context)
		return results.first
	}
	
	public class func count(predicate:NSPredicate, context:NSManagedObjectContext = Stack.shared.mainContext) -> Int {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		var error:NSError?
		let count = context.countForFetchRequest(request, error:&error)
		assert(error != nil, "Counting failed")
		return count
	}
	
	public class func delete(predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> Int {
		let result = self.fetch(predicate:predicate, context:context)
		let count = result.count
		
		for object in result {
			context.deleteObject(object)
		}
		
		return count
	}
}
