//
//  CDKStackTests.m
//  CoreDataKitTests
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CDKStack.h"


@interface CDKStackTests : XCTestCase

@end


@implementation CDKStackTests

- (void)test_initializeStackWithInvalidModel {
	XCTAssertThrows(([[CDKStack alloc] initWithModel:nil]), @"initializing a stack without model should throw");
}

- (void)test_initializeStackWithTestModel {
	
	NSArray *bundles = [NSBundle allBundles];
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
	CDKStack *stack = [[CDKStack alloc] initWithModel:model];
	
	XCTAssertNotNil(stack.storeCoordinator, @"After stack initialization the store coordinator should not be nil");
	XCTAssertNotNil(stack.mainContext, @"After stack initialization the main context should not be nil");
	XCTAssertNotNil(stack.objectModel, @"After stack initialization the model should not be nil");
}

@end
