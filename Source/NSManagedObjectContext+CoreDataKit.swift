//
//  NSManagedObjectContext.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSManagedObjectContext {

	public func childContextWithConcurrencyType(type:NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
		let context = NSManagedObjectContext(concurrencyType:type)
		
		if type == .ConfinementConcurrencyType {
			context.parentContext = self
			
		} else {
			context.performBlockAndWait {
				context.parentContext = self
			}
		}
		return context
	}
	
	public func startMergingSaveNotificationsIntoContext(context:NSManagedObjectContext) {
		let center = NSNotificationCenter.defaultCenter()
		
		center.addObserver(context, selector:"mergeChangesFromContextDidSaveNotification:", name:NSManagedObjectContextDidSaveNotification, object:self)
	}
	
	public func stopMergingSaveNotificationsIntoContext(context:NSManagedObjectContext) {
		let center = NSNotificationCenter.defaultCenter()
		center.removeObserver(context, name:NSManagedObjectContextDidSaveNotification, object:self)
	}
	
	public func objectIDForURI(uri:NSURL) -> NSManagedObjectID? {
		let coordinator = self.persistentStoreCoordinator
		return coordinator.managedObjectIDForURIRepresentation(uri)
	}
}