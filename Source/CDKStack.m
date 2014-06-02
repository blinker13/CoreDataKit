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

- (instancetype)initWithModel:(NSManagedObjectModel *)model URL:(NSURL *)url {
	NSAssert(model, @"A stack must be initialized with a managed object model: %@", model);
	NSAssert(model, @"A stack must be initialized with a valid URL: %@", url);
	
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_storeCoordinator];
		_store = [self loadStoreWithURL:url];
		_model = model;
	}
	return self;
}

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	NSURL *url = [NSURL defaultStoreURL];
	return [self initWithModel:model URL:url];
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

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

- (NSString *)configuration {
	return nil;
}

- (NSDictionary *)options {
	return nil;
}


#pragma mark - private methods

- (NSPersistentStore *)loadStoreWithURL:(NSURL *)url {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [url URLByDeletingLastPathComponent];
	NSPersistentStore *store = nil;
	NSError *error = nil;
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:&error]) {
		store = [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:self.configuration URL:url options:self.options error:&error];
	}
	CDKAssertError(error);
	return store;
}

@end
