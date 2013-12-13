//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


#define CDKDefaultStoreName()	([[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey])


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSManagedObjectModel			*objectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*storeCoordinator;
@property (nonatomic, readonly) NSPersistentStore				*store;

@property (nonatomic, readonly) NSString		*storeConfiguration;
@property (nonatomic, readonly) NSDictionary	*storeOptions;
@property (nonatomic, readonly) NSString		*storeName;
@property (nonatomic, readonly) NSURL			*storeURL;


- (instancetype)initWithModel:(NSManagedObjectModel *)model storeName:(NSString *)name;
- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block;

@end
