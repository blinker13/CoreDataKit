//
//  NSCoder.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSCoder {

	public func encodeManagedObject(object:NSManagedObject, key:String) {
		let objectURI = object.objectID.URIRepresentation()
		self.encodeObject(objectURI, forKey:key)
	}
	
	public func decodeManagedObject(key:String, context:NSManagedObjectContext = CDKStack.shared.mainContext) -> NSManagedObject? {
		let objectURI = self.decodeObjectForKey(key) as NSURL?
		var object:NSManagedObject?
		
		if let uri = objectURI {
			if let objectID = context.objectIDForURI(uri) {
				object = context.existingObjectWithID(objectID, error:nil)
			}
		}
		return object
	}
}
