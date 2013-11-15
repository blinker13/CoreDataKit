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

- (void)test_initializeStackWithInvalidModel {
	XCTAssertThrows(([[CDKStack alloc] initWithModel:nil]), @"initializing a stack without model should throw");
}

- (void)test_initializeStackWithEmptyModel {
	CDKStack *stack = [[CDKStack alloc] init];
	XCTAssertTrue(([stack.objectModel.entities count] == 0), @"There should be 0 to test entities in the model");
}

- (void)test_initializeStackWithTestModel {
	NSArray *bundles = [NSBundle allBundles];
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
	CDKStack *stack = [[CDKStack alloc] initWithModel:model];
	XCTAssertTrue(([stack.objectModel.entities count] == 2), @"There should be 2 to test entities in the model");
}

@end
