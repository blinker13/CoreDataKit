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

- (void)testStackInitialization {
	CDKStack *stack = [CDKStack alloc];
	XCTAssertThrows((stack = [stack initWithModel:nil]), @"initializing a stack without model should throw");
	XCTAssertNoThrow((stack = [stack init]), @"initializing a stack with the all available models should not throw");
	
	XCTAssertNotNil(stack.storeCoordinator, @"After stack initialization the store coordinator should not be nil");
	XCTAssertNotNil(stack.mainContext, @"After stack initialization the main context should not be nil");
	XCTAssertNotNil(stack.objectModel, @"After stack initialization the model should not be nil");
}

@end
