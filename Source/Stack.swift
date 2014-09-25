//
//  Stack.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


/// Static Instance used for shared Stack
private var _sharedStack:Stack?


public class Stack {

	public let model:NSManagedObjectModel
	public let mainContext:NSManagedObjectContext
	public let coordinator:NSPersistentStoreCoordinator
	
	public class var shared:Stack {return _sharedStack!}
	
	
	public init(_ model:NSManagedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)) {
		self.coordinator = NSPersistentStoreCoordinator(managedObjectModel:model)
		self.mainContext = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
		self.mainContext.persistentStoreCoordinator = self.coordinator
		self.model = model
	}
	
	
	public func addStore(type:String = NSSQLiteStoreType, _ url:NSURL = NSURL.defaultStoreURL(), _ configuration:String?) -> NSPersistentStore {
		let options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
		let fileManager = NSFileManager.defaultManager()
		
		fileManager.createDirectoryAtURL(url.URLByDeletingLastPathComponent!, withIntermediateDirectories:true, attributes:nil, error:nil)
		return self.coordinator.addPersistentStoreWithType(type, configuration:configuration, URL:url, options:options, error:nil)!
	}
	
	public func share() {
		_sharedStack = self
	}
}
