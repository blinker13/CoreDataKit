//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*model;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*coordinator;
@property (nonatomic, readonly) NSPersistentStore				*store;

@property (nonatomic, readonly) NSString		*configuration;
@property (nonatomic, readonly) NSDictionary	*options;
@property (nonatomic, readonly) NSURL			*URL;


- (instancetype)initWithModel:(NSManagedObjectModel *)model NS_DESIGNATED_INITIALIZER;

@end
