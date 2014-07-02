//
//  CDKStack.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import CoreData;

@class CDKStackComponents;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*model;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*coordinator;
@property (nonatomic, readonly) NSPersistentStore				*store;


- (instancetype)initWithModel:(NSManagedObjectModel *)model components:(CDKStackComponents *)components NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithModel:(NSManagedObjectModel *)model;

@end
