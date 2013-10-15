//
//  CoreDataKitTests.m
//  CoreDataKitTests
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CDKStack.h"


@interface CoreDataKitTests : XCTestCase

@end


@implementation CoreDataKitTests

- (void)test_initializingStack {
	CDKStack *stack = [CDKStack alloc];
	XCTAssertThrows((stack = [stack initWithModel:nil]), @"initializing a stack without model should throw");
	XCTAssertNoThrow((stack = [stack init]), @"initializing a stack with the all available models should not throw");
	
	XCTAssertNil(stack.storeCoordinator, @"After stack initialization the store coordinator should not be nil");
	XCTAssertNil(stack.mainContext, @"After stack initialization the main context should not be nil");
	XCTAssertNil(stack.objectModel, @"After stack initialization the model should not be nil");
	
	NSUInteger numberOfEntities = [[stack.objectModel entities] count];
	XCTAssertTrue((numberOfEntities == 1), @"there should be only one entity in the test model");
}

@end
