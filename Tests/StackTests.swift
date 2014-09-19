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
	
	//MARK: - Fixtures
	
	func modelFixture() -> NSManagedObjectModel {
		let bundle = NSBundle(forClass:self.dynamicType)
		return NSManagedObjectModel.mergedModelFromBundles([bundle])
	}
	
	func mergedModelFixture() -> NSManagedObjectModel {
		return NSManagedObjectModel.mergedModelFromBundles(nil)
	}
	
	
	//MARK: - Stack Initialization
	
	func testStackInitializer() {
		let stack = CDKStack()
		
		XCTAssertEqual(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model")
		XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store")
		XCTAssertEqual(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator")
		XCTAssertEqual(stack.model, self.mergedModelFixture(), "The convenience initializer model should be a merged model from all bundles")
		XCTAssertEqual(stack.mainContext.concurrencyType, NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType, "The main context should use the main queue")
	}
	
	func testStackInitializerWithModel() {
		let model = self.modelFixture()
		let stack = CDKStack(model)
		
		XCTAssertEqual(stack.model, model, "The convenience initializer model should be a merged model from all bundles")
		XCTAssertEqual(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model")
		XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store")
		XCTAssertEqual(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator")
		XCTAssertEqual(stack.mainContext.concurrencyType, NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType, "The main context should use the main queue")
	}
	
	
	//MARK: - Stack Properties
	
	func testStackPropertyGetters() {
		let stack = CDKStack()
		
		XCTAssertEqual(stack.mainContext, stack.mainContext, "The main context getter should not be a factory method")
		XCTAssertEqual(stack.coordinator, stack.coordinator, "The coordinator getter should not be a factory method")
		XCTAssertEqual(stack.model, stack.model, "The model getter should not be a factory method")
	}
}
