//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKStack.h"
#import "CDKDefines.h"
#import "NSManagedObjectContext+CoreDataKit.h"
#import "NSURL+CoreDataKit.h"


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model storeName:(NSString *)name {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_storeCoordinator];
		_store = [self loadStoreWithName:name];
		_model = model;
	}
	return self;
}

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	return [self initWithModel:model storeName:nil];
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
	return nil;
}

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block {
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	
	[context performBlock:^{
		[context setUndoManager:nil];
		[context setPersistentStoreCoordinator:self.storeCoordinator];
		[context startMergingSaveNotificationsIntoContext:self.mainContext];
		
		block(context);
		
		[context stopMergingSaveNotificationsIntoContext:self.mainContext];
	}];
}


#pragma mark - private methods

- (NSPersistentStore *)loadStoreWithName:(NSString *)name {
	NSURL *storeURL = [NSURL defaultStoreURLWithName:name];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [storeURL URLByDeletingLastPathComponent];
	NSPersistentStore *store = nil;
	NSError *error = nil;
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error]) {
		store = [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configuration URL:storeURL options:self.options error:&error];
	}
	CDKAssertError(error);
	return store;
}

@end
