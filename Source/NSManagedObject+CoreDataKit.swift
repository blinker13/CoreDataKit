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

	public class func insert(context:NSManagedObjectContext = CDKStack.shared.mainContext) -> NSManagedObject {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as NSManagedObject
	}
	
	
	//MARK: - Fetch
	
	public class func fetch(request:NSFetchRequest, context:NSManagedObjectContext = CDKStack.shared.mainContext) -> [NSManagedObject] {
		
		var error:NSError?
		let result = context.executeFetchRequest(request, error:&error) as [NSManagedObject]
		assert(error != nil, "Fetching failed")
		
		return result
	}
	
	public class func fetch(predicate:NSPredicate? = nil, context:NSManagedObjectContext = CDKStack.shared.mainContext) -> [NSManagedObject] {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		return self.fetch(request, context:context)
	}
	
	
	//MARK: - First
	
	public class func first(predicate:NSPredicate? = nil, context:NSManagedObjectContext = CDKStack.shared.mainContext) -> NSManagedObject? {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		request.fetchLimit = 1
		
		let results = self.fetch(request, context:context)
		return results.first
	}
	
	
	//MARK: - Count
	
	public class func count(predicate:NSPredicate, context:NSManagedObjectContext = CDKStack.shared.mainContext) -> Int {
		let request = NSFetchRequest(entityName:self.entityName)
		request.predicate = predicate
		
		var error:NSError?
		let count = context.countForFetchRequest(request, error:&error)
		assert(error != nil, "Counting failed")
		return count
	}
}
