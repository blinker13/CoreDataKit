//
//  CDKStack.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public class CDKStack {

	public let objectModel:NSManagedObjectModel
	public let mainContext:NSManagedObjectContext
	public let coordinator:NSPersistentStoreCoordinator
	
	
	public init(model:NSManagedObjectModel) {
		coordinator = NSPersistentStoreCoordinator(managedObjectModel:model)
		mainContext = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
		mainContext.persistentStoreCoordinator = self.coordinator
		objectModel = model
	}
	
	public convenience init() {
		let model = NSManagedObjectModel.mergedModelFromBundles(nil)
		self.init(model: model)
	}
}


public extension CDKStack {

	public func addStoreWithInfo(info:CDKStoreInfo) -> NSPersistentStore {
		let fileManager = NSFileManager.defaultManager()
		let directoryURL = info.directoryURL()
		
		fileManager.createDirectoryAtURL(directoryURL, withIntermediateDirectories:true, attributes:nil, error:nil)
		return self.coordinator.addPersistentStoreWithType(info.type, configuration:info.configuration, URL:info.URL, options:info.options, error:nil)!
	}
	
	public func addStore() -> NSPersistentStore {
		let info = CDKStoreInfo()
		return self.addStoreWithInfo(info)
	}
}
