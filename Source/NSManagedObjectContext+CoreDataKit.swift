//
//  NSManagedObjectContext.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSManagedObjectContext {
	
	public func startMergingChangesInto(context:NSManagedObjectContext) {
		let action = Selector("mergeChangesFromContextDidSaveNotification:")
		let name = NSManagedObjectContextDidSaveNotification;
		let center = NSNotificationCenter.defaultCenter()
		
		center.addObserver(context, selector:action, name:name, object:self)
	}
	
	public func stopMergingChangesInto(context:NSManagedObjectContext) {
		let name = NSManagedObjectContextDidSaveNotification;
		let center = NSNotificationCenter.defaultCenter()
		
		center.removeObserver(context, name:name, object:self)
	}
}


public extension NSManagedObjectContext {

	public func objectIDForURI(uri:NSURL) -> NSManagedObjectID? {
		let coordinator = self.persistentStoreCoordinator
		return coordinator.managedObjectIDForURIRepresentation(uri)
	}
}
