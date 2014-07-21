//
//  NSCoder+CoreDataKit.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


extension NSCoder {

	func encodeManagedObject(object:NSManagedObject, key:String) {
		let objectURI = object.objectID.URIRepresentation()
		self.encodeObject(objectURI, forKey:key)
	}
	
	func decodeManagedObjectForKey(key:String, inContext context:NSManagedObjectContext) -> NSManagedObject? {
		let objectURI = self.decodeObjectForKey(key) as? NSURL
		var object:NSManagedObject?
		
		if let uri = objectURI {
			var error:NSError?
			let objectID = context.objectIDForURI(uri)
			object = context.existingObjectWithID(objectID, error:&error)
			assert(!error, "Retrieving the object failed")
		}
		return object
	}
}
