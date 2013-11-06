//
//  NSManagedObjectContext+CDKObserving.m
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObjectContext+CDKObserving.h"


@implementation NSManagedObjectContext (CDKSaveObserving)

- (void)startMergingSaveNotificationsFromContext:(NSManagedObjectContext *)context {
	SEL action = @selector(mergeChangesFromContextDidSaveNotification:);
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:action name:NSManagedObjectContextDidSaveNotification object:context];
}

- (void)stopMergingSaveNotificationsFromContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:context];
}

@end
