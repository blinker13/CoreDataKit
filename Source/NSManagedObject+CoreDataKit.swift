//
//  NSManagedObject.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSManagedObject {

	public class var entityName:String {return NSStringFromClass(self)}
	
	public class func insertInContext(context:NSManagedObjectContext) -> NSManagedObject {
		return NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext:context) as NSManagedObject
	}
	
	public class func attributeTypeForKey(key:String, inContext:NSManagedObjectContext) -> NSAttributeType {
		let entity = NSEntityDescription.entityForName(self.entityName, inManagedObjectContext:inContext)
		let attribute = entity.attributesByName[key] as NSAttributeDescription
		return attribute.attributeType
	}
	
	public var absoluteStringURI:String {
		let uri = self.objectID.URIRepresentation()
		return uri.absoluteString
	}
}
