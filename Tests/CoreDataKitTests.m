//
//  CoreDataKitTests.m
//  CoreDataKitTests
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CDKStack.h"

#import "NSPersistentStore+CoreDataKit.h"


@interface CoreDataKitTests : XCTestCase

@end


@implementation CoreDataKitTests

- (void)tearDown {
	[super tearDown];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	[fileManager removeItemAtURL:[urls firstObject] error:nil];
}


#pragma mark -

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

- (void)test_addingSQLiteFile {
	CDKStack *stack = [self stackFixture];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *directoryPath = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
	NSURL *path = [directoryPath URLByAppendingPathComponent:@"Test.sqlite"];
	
	NSError *error = nil;
	[stack addSQLiteStoreWithURL:path options:nil error:&error];
	XCTAssertNil(error, @"%@", [error localizedDescription]);
	
	XCTAssertTrue([fileManager fileExistsAtPath:[path path]], @"Test.sqlite was not added");
}


#pragma mark - fixtures

- (CDKStack *)stackFixture {
	NSArray *bundles = [NSBundle allBundles];
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
	return [[CDKStack alloc] initWithModel:model];
}

@end
