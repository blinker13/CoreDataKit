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

	public class func insert<MO:NSManagedObject>(context:NSManagedObjectContext = Stack.shared.mainContext) -> MO {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as MO
	}
	
	public class func lazy<MO:NSManagedObject>(info:[String:AnyObject], context:NSManagedObjectContext = Stack.shared.mainContext) -> MO {
		
		if info.count > 0 {
			let filter = NSPredicate.require(info)
			if let object = self.first(filter) {
				return object as MO
			}
		}
		
		let object = self.insert(context:context)
		object.setValuesForKeysWithDictionary(info)
		return object as MO
	}
	
	//TODO: replace explicit return value with a generic value type
	public class func fetch(request:NSFetchRequest, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		
		var error:NSError?
		let result = context.executeFetchRequest(request, error:&error) as [NSManagedObject]
		assert(error != nil, "Fetching failed")
		
		return result
	}
	
	//TODO: replace explicit return value with a generic value type
	public class func fetch(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> [NSManagedObject] {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		return self.fetch(request, context:context)
	}
	
	public class func first<MO:NSManagedObject>(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> MO? {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		request.fetchLimit = 1
		
		let results = self.fetch(request, context:context) as [MO]
		return results.first
	}
	
	public class func count(_ predicate:NSPredicate? = nil, context:NSManagedObjectContext = Stack.shared.mainContext) -> Int {
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
