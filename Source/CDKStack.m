//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKStack.h"
#import "NSManagedObjectContext+CoreDataKit.h"


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		[_mainContext setPersistentStoreCoordinator:_storeCoordinator];
		_objectModel = model;
	}
	return self;
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

- (NSPersistentStore *)addSQLiteStoreWithURL:(NSURL *)url options:(NSDictionary *)options error:(NSError **)error {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [url URLByDeletingLastPathComponent];
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:error]) {
		return [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:error];
	}
	return nil;
}

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block {
	if (block) {
		NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
		
		[context performBlock:^{
			[context setPersistentStoreCoordinator:self.storeCoordinator];
			[context startMergingSaveNotificationsIntoContext:self.mainContext];
			block(context);
			[context stopMergingSaveNotificationsIntoContext:self.mainContext];
		}];
	}
}

@end
