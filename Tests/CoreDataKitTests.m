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
	NSURL *url = [self sqliteUrlFixture];
	
	NSError *error = nil;
	[stack addSQLiteStoreWithURL:url options:nil error:&error];
	XCTAssertNil(error, @"%@", [error localizedDescription]);
	
	XCTAssertTrue([fileManager fileExistsAtPath:[url path]], @"Test.sqlite was not added");
}


#pragma mark - fixtures

- (CDKStack *)stackFixture {
	NSArray *bundles = [NSBundle allBundles];
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
	return [[CDKStack alloc] initWithModel:model];
}

- (CDKStack *)persistentStackFixture {
	CDKStack *stack = [self stackFixture];
	NSURL *fileURL = [self sqliteUrlFixture];
	[stack addSQLiteStoreWithURL:fileURL options:nil error:nil];
	return stack;
}

- (NSURL *)sqliteUrlFixture {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *directoryPath = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
	return [directoryPath URLByAppendingPathComponent:@"Test.sqlite"];
}

@end
