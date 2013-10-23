//
//  CDKStack.m
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKStack.h"


NSString * const CDKSQLiteExtension	=	@"sqlite";


@implementation CDKStack

@synthesize mainContext	=	_mainContext;


+ (NSURL *)defaultDirectory {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *url = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier];
	
	NSError *error = nil;
	[fileManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
	NSAssert(!error, [error localizedDescription]);
	
	return url;
}

+ (NSString *)defaultStoreName {
	NSDictionary *mainBundleInfo = [[NSBundle mainBundle] infoDictionary];
	NSString *fileName = [mainBundleInfo objectForKey:(__bridge NSString *)kCFBundleExecutableKey];
	return [fileName stringByAppendingPathExtension:CDKSQLiteExtension];
}


#pragma mark -

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	if ((self = [super init])) {
		_storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
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

- (NSManagedObjectContext *)mainContext {
	if (!_mainContext) {
		_mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		
		[_mainContext performBlockAndWait:^{
			[_mainContext setPersistentStoreCoordinator:self.storeCoordinator];
		}];
	}
	return _mainContext;
}

- (NSPersistentStore *)addSQLiteStoreWithOptions:(NSDictionary *)options error:(NSError *__autoreleasing *)error {
	Class stackClass = [self class];
	NSString *fileName = [stackClass defaultStoreName];
	NSURL *url = [[stackClass defaultDirectory] URLByAppendingPathComponent:fileName];
	return [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:error];
}

@end
