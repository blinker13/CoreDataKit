//
//  Stack.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


class Stack {

	let objectModel:NSManagedObjectModel
	let mainContext:NSManagedObjectContext
	let coordinator:NSPersistentStoreCoordinator
	let store:NSPersistentStore
	
	
	init(model:NSManagedObjectModel, components:StackComponents) {
		coordinator = NSPersistentStoreCoordinator(managedObjectModel:model)
		mainContext = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
		mainContext.persistentStoreCoordinator = self.coordinator
		objectModel = model
		
		let directoryURL = components.URL.URLByDeletingLastPathComponent
		let fileManager = NSFileManager.defaultManager()
		var aStore:NSPersistentStore?
		var error:NSError?
		
		if fileManager.createDirectoryAtURL(directoryURL, withIntermediateDirectories:true, attributes:nil, error:&error) {
			aStore = coordinator.addPersistentStoreWithType(components.type, configuration:components.configuration, URL:components.URL, options:components.options, error:&error)
		}
		assert(!error, "Could not initialize Stack")
		store = aStore!
	}
	
	convenience init(model:NSManagedObjectModel) {
		let components = StackComponents()
		self.init(model:model, components:components)
	}
	
	convenience init() {
		let model = NSManagedObjectModel.mergedModelFromBundles(nil)
		self.init(model: model)
	}
}
