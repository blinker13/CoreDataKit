//
//  CDKStackTests.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XCTestCase+Fixtures.h"


@interface CDKStackTests : XCTestCase
@end


@implementation CDKStackTests

- (void)testStackInitialization {
	CDKStack *stack = [[CDKStack alloc] init];
	
	XCTAssertEqualObjects(stack.model, stack.model, ".model should always return the same model");
	XCTAssertEqualObjects(stack.mainContext, stack.mainContext, ".mainContext should always return the same context");
	XCTAssertEqualObjects(stack.coordinator, stack.coordinator, ".coordinator should always return the same coordinator");
	XCTAssertEqualObjects(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model");
	XCTAssertEqualObjects(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator");
	XCTAssertEqualObjects(stack.model, self.fixtureMergedModel, "The convenience initializer model should be a merged model from all bundles");
	XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store");
	XCTAssertEqual(stack.mainContext.concurrencyType, NSMainQueueConcurrencyType, "The main context should use the main queue");
}

- (void)testStackInitializationWithModel {
	NSManagedObjectModel *fixtureModel = [self fixtureModel];
	CDKStack *stack = [[CDKStack alloc] initWithModel:fixtureModel];
	
	XCTAssertEqualObjects(stack.model, stack.model, ".model should always return the same model");
	XCTAssertEqualObjects(stack.mainContext, stack.mainContext, ".mainContext should always return the same context");
	XCTAssertEqualObjects(stack.coordinator, stack.coordinator, ".coordinator should always return the same coordinator");
	XCTAssertEqualObjects(stack.model, stack.coordinator.managedObjectModel, "The coordinator is not connected to the model");
	XCTAssertEqualObjects(stack.model, fixtureModel, "The designated initializer should set .model");
	XCTAssertEqualObjects(stack.coordinator, stack.mainContext.persistentStoreCoordinator, "Main context is not connected to the coordinator");
	XCTAssertEqual(stack.coordinator.persistentStores.count, 0, "After initialization a stack should not have a persistent store");
	XCTAssertEqual(stack.mainContext.concurrencyType, NSMainQueueConcurrencyType, "The main context should use the main queue");
}


#pragma mark -

@end
