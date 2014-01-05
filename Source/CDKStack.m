//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKStack.h"
#import "NSManagedObjectContext+CoreDataKit.h"


NSString * const CDKSQLiteExtension	=	@"sqlite";


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model storeName:(NSString *)name {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_storeCoordinator];
		_storeName = name ?: CDKDefaultStoreName();
		_objectModel = model;
		
		[self createStore];
	}
	return self;
}

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	return [self initWithModel:model storeName:CDKDefaultStoreName()];
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

- (NSString *)storeConfiguration {
	return nil;
}

- (NSURL *)storeURL {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *directoryURL = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
	NSURL *fileURL = [directoryURL URLByAppendingPathComponent:self.storeName isDirectory:NO];
	return [fileURL URLByAppendingPathExtension:CDKSQLiteExtension];
}

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block {
	if (block) {
		NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
		
		[context performBlock:^{
			[context setUndoManager:nil];
			[context setPersistentStoreCoordinator:self.storeCoordinator];
			[context startMergingSaveNotificationsIntoContext:self.mainContext];
			block(context);
			[context stopMergingSaveNotificationsIntoContext:self.mainContext];
		}];
	}
}


#pragma mark - private methods

- (NSPersistentStore *)createStore {
	NSURL *storeURL = [self storeURL];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [storeURL URLByDeletingLastPathComponent];
	
	NSError *error = nil;
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error]) {
		return [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												   configuration:self.storeConfiguration
															 URL:storeURL
														 options:self.storeOptions
														   error:&error];
	}
	NSAssert(error, [error localizedDescription]);
	return nil;
}

@end
