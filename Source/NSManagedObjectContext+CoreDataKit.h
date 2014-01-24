//
//  NSManagedObjectContext+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSManagedObjectContext (CoreDataKit)

- (instancetype)childContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type;

- (NSUInteger)deleteAllObjects:(NSFetchRequest *)request error:(NSError **)error;

- (void)startMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context;
- (void)stopMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context;

- (NSManagedObjectID *)objectIDForURI:(NSURL *)uri;

@end
