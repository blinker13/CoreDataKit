//
//  Fixtures.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 28/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import XCTest
import CoreDataKit


extension XCTestCase {

	var fixtureModel:NSManagedObjectModel {
		let bundle = NSBundle(forClass:self.dynamicType)
		return NSManagedObjectModel.mergedModelFromBundles([bundle])
	}
	
	var fixtureMergedModel:NSManagedObjectModel {
		return NSManagedObjectModel.mergedModelFromBundles(nil)
	}
	
	var fixtureStackWithoutStore:Stack {
		return Stack(model:self.fixtureModel)
	}
	
	var fixtureStack:Stack {
		let stack = self.fixtureStackWithoutStore
		stack.coordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration:nil, URL:nil, options:nil, error:nil)
		return stack
	}
}
