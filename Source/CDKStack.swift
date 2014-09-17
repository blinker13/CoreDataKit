//
//  CDKStack.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public class CDKStack {

	public let model:NSManagedObjectModel
	public let mainContext:NSManagedObjectContext
	public let coordinator:NSPersistentStoreCoordinator
	
	
	public init(model:NSManagedObjectModel) {
		self.coordinator = NSPersistentStoreCoordinator(managedObjectModel:model)
		self.mainContext = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
		self.mainContext.persistentStoreCoordinator = self.coordinator
		self.model = model
	}
	
	public convenience init() {
		let model = NSManagedObjectModel.mergedModelFromBundles(nil)
		self.init(model:model)
	}
}


public extension CDKStack {

	/// Adds a new persistent store with specific information and returns the new store
	public func addStore(info:CDKStoreInfo = CDKStoreInfo()) -> NSPersistentStore {
		let fileManager = NSFileManager.defaultManager()
		
		fileManager.createDirectoryAtURL(info.directoryURL, withIntermediateDirectories:true, attributes:nil, error:nil)
		return self.coordinator.addPersistentStoreWithType(info.type, configuration:info.configuration, URL:info.URL, options:info.options, error:nil)!
	}
}
