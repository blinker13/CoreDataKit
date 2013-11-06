//
//  NSManagedObjectContext+CDKObserving.h
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSManagedObjectContext (CDKObserving)

- (void)startMergingSaveNotificationsFromContext:(NSManagedObjectContext *)context;
- (void)stopMergingSaveNotificationsFromContext:(NSManagedObjectContext *)context;

@end
