//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*objectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*storeCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;


- (instancetype)initWithModel:(NSManagedObjectModel *)model;

- (NSPersistentStore *)addSQLiteStoreWithURL:(NSURL *)url options:(NSDictionary *)options error:(NSError *__autoreleasing *)error;

- (NSManagedObjectContext *)childContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type;
- (NSManagedObjectContext *)rootContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type;

- (void)performBlockInBackground:(void (^)(NSManagedObjectContext *context))block;

@end
