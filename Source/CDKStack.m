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

@synthesize mainContext	=	_mainContext;


- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_objectModel = model;
	}
	return self;
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}


#pragma mark -

- (NSManagedObjectContext *)mainContext {
	if (!_mainContext) {
		_mainContext = [self rootContextWithConcurrencyType:NSMainQueueConcurrencyType];
	}
	return _mainContext;
}

- (NSPersistentStore *)addSQLiteStoreWithURL:(NSURL *)url options:(NSDictionary *)options error:(NSError *__autoreleasing *)error {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *directoryURL = [url URLByDeletingLastPathComponent];
	
	if ([fileManager createDirectoryAtURL:directoryURL withIntermediateDirectories:YES attributes:nil error:error]) {
		return [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:error];
	}
	return nil;
}

- (NSManagedObjectContext *)childContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	
	if (type == NSConfinementConcurrencyType) {
		[context setParentContext:self.mainContext];
		
	} else {
		[context performBlockAndWait:^{
			[context setParentContext:self.mainContext];
		}];
	}
	return context;
}

- (NSManagedObjectContext *)rootContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	
	if (type == NSConfinementConcurrencyType) {
		[context setPersistentStoreCoordinator:self.storeCoordinator];
		
	} else {
		[context performBlockAndWait:^{
			[context setPersistentStoreCoordinator:self.storeCoordinator];
		}];
	}
	return context;
}

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block {
	if (block) {
		NSManagedObjectContext *context = [self rootContextWithConcurrencyType:NSPrivateQueueConcurrencyType];
		
		[context performBlock:^{
			[context startMergingSaveNotificationsIntoContext:self.mainContext];
			block(context);
			[context stopMergingSaveNotificationsIntoContext:self.mainContext];
		}];
	}
}

@end
