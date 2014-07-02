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


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model components:(CDKStackComponents *)components {
	NSAssert(components, @"A stack must be initialized with valid components: %@", components);
	
	if ((self = [super init])) {
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_coordinator];
		_store = [self loadStoreWithComponents:components];
		_model = model;
	}
	return self;
}

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	CDKStackComponents *components = [[CDKStackComponents alloc] init];
	return [self initWithModel:model components:components];
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
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
