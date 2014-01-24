//
//  NSManagedObjectContext+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObjectContext+CoreDataKit.h"
#import "NSManagedObject+CoreDataKit.h"


@implementation NSManagedObjectContext (CoreDataKit)

- (instancetype)childContextWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type {
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:type];
	
	if (type == NSConfinementConcurrencyType) {
		[context setParentContext:self];
		
	} else {
		[context performBlockAndWait:^{
			[context setParentContext:self];
		}];
	}
	return context;
}


#pragma mark - manipulation

- (NSUInteger)deleteAllObjects:(NSFetchRequest *)request error:(NSError **)error {
	NSArray *objects = [self executeFetchRequest:request error:error];
	for (NSManagedObject *object in objects) {
		[self deleteObject:object];
	}
	return [objects count];
}


#pragma mark - auto merge save changes

- (void)startMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context {
	SEL action = @selector(mergeChangesFromContextDidSaveNotification:);
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:context selector:action name:NSManagedObjectContextDidSaveNotification object:self];
}

- (void)stopMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:context name:NSManagedObjectContextDidSaveNotification object:self];
}


#pragma mark -

- (NSManagedObjectID *)objectIDForURI:(NSURL *)uri {
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	return [coordinator managedObjectIDForURIRepresentation:uri];
}

@end
