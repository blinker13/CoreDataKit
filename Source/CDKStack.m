//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKStack.h"
#import "CDKUtility.h"


NSString * const CDKSQLiteSuffix	=	@".sqlite";


@implementation CDKStack

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		
		[_mainContext performBlockAndWait:^{
			[_mainContext setPersistentStoreCoordinator:_storeCoordinator];
		}];
		_objectModel = model;
	}
	return self;
}

- (instancetype)init {
	NSArray *bundles = [NSBundle allBundles];
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
	return [self initWithModel:model];
}


#pragma mark -

- (NSPersistentStore *)addSQLStoreWithName:(NSString *)name options:(NSDictionary *)options error:(NSError *__autoreleasing *)error {
	NSAssert(name, @"A new persistent store needs a valid name");
	
	NSString *file = [name stringByAppendingString:CDKSQLiteSuffix];
	NSURL *url = [CDKDocumentsDirectory() URLByAppendingPathComponent:file];
	
	return [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:error];
}

@end
