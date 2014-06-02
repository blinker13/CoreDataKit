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


- (instancetype)initWithModel:(NSManagedObjectModel *)model URL:(NSURL *)url;
- (instancetype)initWithModel:(NSManagedObjectModel *)model;

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block;

- (NSString *)configuration;
- (NSDictionary *)options;

@end
