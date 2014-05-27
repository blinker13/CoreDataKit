//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*model;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*storeCoordinator;
@property (nonatomic, readonly) NSPersistentStore				*store;

@property (nonatomic, readonly) NSString		*configuration;
@property (nonatomic, readonly) NSDictionary	*options;


- (instancetype)initWithModel:(NSManagedObjectModel *)model storeName:(NSString *)name;
- (instancetype)initWithModel:(NSManagedObjectModel *)model;

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block;

@end
