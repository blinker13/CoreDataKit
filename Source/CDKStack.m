//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "CDKStack.h"
#import "CDKAssert.h"
#import "CDKStackComponents.h"

#import "NSURL+CoreDataKit.h"


@implementation CDKStack

- (instancetype)initWithComponents:(CDKStackComponents *)components {
	NSAssert(components, @"A stack must be initialized with valid components: %@", components);
	
	if ((self = [super init])) {
		_model = [components model];
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_coordinator];
		_store = [self loadStoreWithComponents:components];
	}
	return self;
}

- (instancetype)init {
	CDKStackComponents *components = [[CDKStackComponents alloc] init];
	return [self initWithComponents:components];
}


#pragma mark - private methods

- (NSPersistentStore *)loadStoreWithComponents:(CDKStackComponents *)components {
	NSURL *directoryURL = [components.URL URLByDeletingLastPathComponent];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSPersistentStore *store = nil;
	NSError *error = nil;
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error]) {
		store = [self.coordinator addPersistentStoreWithType:components.type configuration:components.configuration URL:components.URL options:components.options error:&error];
	}
	CDKAssertError(error);
	return store;
}

@end
