//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "CDKStack.h"
#import "CDKAssert.h"

#import "NSURL+CoreDataKit.h"


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	NSAssert(model, @"A stack must be initialized with a managed object model: %@", model);
	
	if ((self = [super init])) {
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_coordinator];
		_store = [self loadStore];
		_model = model;
	}
	return self;
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

- (NSString *)configuration {
	return nil;
}

- (NSDictionary *)options {
	return @{ NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES };
}

- (NSURL *)URL {
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *infos = [bundle infoDictionary];
	NSString *name = [infos objectForKey:(__bridge NSString *)kCFBundleExecutableKey];
	return [NSURL storeURLWithName:name];
}


#pragma mark - private methods

- (NSPersistentStore *)loadStore {
	NSURL *url = [self URL];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [url URLByDeletingLastPathComponent];
	NSPersistentStore *store = nil;
	NSError *error = nil;
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error]) {
		store = [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configuration URL:url options:self.options error:&error];
	}
	CDKAssertError(error);
	return store;
}

@end
