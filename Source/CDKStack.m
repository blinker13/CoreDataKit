//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "CDKStack.h"
#import "NSURL+CoreDataKit.h"


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	if ((self = [super init])) {
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		_mainContext.persistentStoreCoordinator = _coordinator;
		_model = model;
	}
	return self;
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options configuration:(NSString *)configuration {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = url.URLByDeletingLastPathComponent;
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:nil]) {
		return [self.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:configuration URL:url options:options error:nil];
	}
	return nil;
}

- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options {
	return [self addStoreAtURL:url withOptions:options configuration:nil];
}

- (NSPersistentStore *)addStoreAtURL:(NSURL *)url {
	NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES};
	return [self addStoreAtURL:url withOptions:options];
}

- (NSPersistentStore *)addStore {
	NSURL *url = [NSURL defaultStoreURL];
	return [self addStoreAtURL:url];
}

@end
