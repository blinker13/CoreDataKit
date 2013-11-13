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

- (NSUInteger)countForEntity:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate error:(NSError **)error;

- (void)startMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context;
- (void)stopMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context;

@end
