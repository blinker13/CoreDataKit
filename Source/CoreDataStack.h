//
//  CoreDataStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;
@import CoreData;


@interface CoreDataStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*model;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*coordinator;


- (instancetype)initWithModel:(NSManagedObjectModel *)model NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options configuration:(NSString *)configuration;
- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options;
- (NSPersistentStore *)addStoreAtURL:(NSURL *)url;
- (NSPersistentStore *)addStore;

@end
