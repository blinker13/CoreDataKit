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
	
	public var URI:NSURL {
		return self.objectID.URIRepresentation()
	}
}


public extension NSManagedObject {

	public class func insert(_ context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as NSManagedObject
	}
	
	public class func lazy(info:[String:AnyObject], _ context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject {
		
		if info.count > 0 {
			let filter = NSPredicate.require(info)
			if let object = self.first(filter, context:context) {
				return object
			}
		}
		
		let object = self.insert(context)
		object.setValuesForKeysWithDictionary(info)
		return object
	}
	
	public class func fetch(#request:NSFetchRequest, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		
		var error:NSError?
		let result = context.executeFetchRequest(request, error:&error) as [NSManagedObject]
		assert(error != nil, "Fetching failed")
		
		return result
	}
	
	public class func fetch(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		return self.fetch(request:request, context:context)
	}
	
	public class func first(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> NSManagedObject? {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		request.fetchLimit = 1
		
		let results = self.fetch(request:request, context:context)
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
	
	public class func delete(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> Int {
		let result = self.fetch(predicate, context:context)
		let count = result.count
		
		for object in result {
			context.deleteObject(object)
		}
		
		return count
	}
}
