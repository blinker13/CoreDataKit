//
//  NSManagedObjectContext+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface NSManagedObjectContext (CoreDataKit)

- (void)startForwardingChangesToContext:(NSManagedObjectContext *)context;
- (void)stopForwardingChangesToContext:(NSManagedObjectContext *)context;

- (NSManagedObject *)managedObjectForObjectURI:(NSURL *)objectURI;

@end
