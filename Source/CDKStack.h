//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import Foundation;
@import CoreData;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*objectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*storeCoordinator;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;


+ (NSURL *)defaultDirectory;
+ (NSString *)defaultStoreName;

- (instancetype)initWithModel:(NSManagedObjectModel *)model;
- (NSPersistentStore *)addSQLiteStoreWithOptions:(NSDictionary *)options error:(NSError *__autoreleasing *)error;

@end
