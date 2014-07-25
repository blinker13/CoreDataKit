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
	
	//MARK: -
	
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
	
	//MARK: -
	
	public func addStore(components:CDKStoreInfo) -> NSPersistentStore {
		let fileManager = NSFileManager.defaultManager()
		let directoryURL = components.directoryURL()
		
		fileManager.createDirectoryAtURL(directoryURL, withIntermediateDirectories:true, attributes:nil, error:nil)
		
		return self.coordinator.addPersistentStoreWithType(components.type, configuration:components.configuration, URL:components.URL, options:components.options, error:nil)
	}
	
	public func addStore() -> NSPersistentStore {
		let info = CDKStoreInfo()
		return self.addStore(info)
	}
}
