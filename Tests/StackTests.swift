//
//  StackTests.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 17/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import XCTest
import CoreDataKit


class StackTests: XCTestCase {

	func testStackInitializer() {
		let type = NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType
		let stack = Stack()
		
		XCTAssertEqual(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model")
		XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store")
		XCTAssertEqual(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator")
		XCTAssertEqual(stack.model, self.fixtureMergedModel, "The convenience initializer model should be a merged model from all bundles")
		XCTAssertEqual(stack.mainContext.concurrencyType, type, "The main context should use the main queue")
		XCTAssertEqual(stack.mainContext, stack.mainContext, ".mainContext should always return the same context")
		XCTAssertEqual(stack.coordinator, stack.coordinator, ".coordinator should always return the same coordinator")
		XCTAssertEqual(stack.model, stack.model, ".model should always return the same model")
	}
	
	func testStackInitializerWithModel() {
		let type = NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType
		let model = self.fixtureModel
		let stack = Stack(model)
		
		XCTAssertEqual(stack.model, model, "The convenience initializer model should be a merged model from all bundles")
		XCTAssertEqual(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model")
		XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store")
		XCTAssertEqual(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator")
		XCTAssertEqual(stack.mainContext.concurrencyType, type, "The main context should use the main queue")
		XCTAssertEqual(stack.mainContext, stack.mainContext, ".mainContext should always return the same context")
		XCTAssertEqual(stack.coordinator, stack.coordinator, ".coordinator should always return the same coordinator")
		XCTAssertEqual(stack.model, stack.model, ".model should always return the same model")
	}
	
	
	//MARK - Stack Store
	
//	func testStackAddStore() {
//		let stack = self.fixtureStack
//		let info = self.fixtureStoreInfo
//		let store = stack.addStore(info)
//		
//		XCTAssertEqual(stack.coordinator.persistentStores.count, 1, "A new store should have been initialized")
//		XCTAssertEqual(stack.coordinator.persistentStores.first as NSPersistentStore, store, "The store does not equal the returned store")
////		XCTAssertEqual(info.configuration, store.configurationName, "The store configuration does not equal the input configuration")
////		XCTAssertEqual(info.options, store.options, "The store options do not equal the input options")
//		XCTAssertEqual(info.type, store.type, "The store type does not equal the input type")
//		XCTAssertEqual(info.URL, store.URL!, "The store URL does not equal the input URL")
//	}
}
