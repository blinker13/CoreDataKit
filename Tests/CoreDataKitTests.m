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
	XCTAssertNoThrow((stack = [stack init]), @"initializing a stack with the test model should not throw");
	
	NSManagedObjectModel *model = [stack objectModel];
	NSUInteger numberOfEntities = [[model entities] count];
	XCTAssertTrue((numberOfEntities == 1), @"there should be only one entity in the test model");
}

@end
