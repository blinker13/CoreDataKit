//
//  NSFetchedResultsController+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "NSFetchedResultsController+CoreDataKit.h"
#import "NSManagedObjectContext+CoreDataKit.h"
#import "NSManagedObject+CoreDataKit.h"
#import "CDKAssert.h"


@implementation NSFetchedResultsController (CoreDataKit)

- (NSInteger)numberOfSections {
	return [self.sections count];
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (NSArray *)objectsForIndexPaths:(NSArray *)indexPaths {
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	
	for (NSIndexPath *indexPath in indexPaths) {
		NSManagedObject *object = [self objectAtIndexPath:indexPath];
		[objects addObject:object];
	}
	return objects;
}

- (NSString *)identifierForObjectAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *object = [self objectAtIndexPath:indexPath];
	return [object stringID];
}

- (NSIndexPath *)indexPathForObjectWithIdentifier:(NSString *)identifier {
	NSURL *uri = [[NSURL alloc] initWithString:identifier];
	NSManagedObjectID *objectID = [self.managedObjectContext objectIDForURI:uri];
	
	NSError *error = nil;
	NSManagedObject *object = [self.managedObjectContext existingObjectWithID:objectID error:&error];
	CDKAssertError(error);
	
	return [self indexPathForObject:object];
}

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex update:(CDKMoveHandler)handler {
	NSMutableOrderedSet *objects = [[NSMutableOrderedSet alloc] initWithArray:self.fetchedObjects];
	NSIndexSet *indexes = [[NSIndexSet alloc] initWithIndex:index];
	[objects moveObjectsAtIndexes:indexes toIndex:newIndex];
	
	if (handler) {
		NSUInteger currentIndex = MIN(index, newIndex);
		NSUInteger endIndex = MAX(index, newIndex);
		
		__weak id<NSFetchedResultsControllerDelegate> delegate = self.delegate;
		[self setDelegate:nil];
		
		for (; currentIndex <= endIndex; currentIndex++) {
			id object = [objects objectAtIndex:currentIndex];
			handler(object, currentIndex);
		}
		[self setDelegate:delegate];
	}
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath {
	NSManagedObject *object = [self objectAtIndexPath:indexPath];
	[self.managedObjectContext deleteObject:object];
}

- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths {
	NSArray *objects = [self objectsForIndexPaths:indexPaths];
	
	for (NSManagedObject *object in objects) {
		[self.managedObjectContext deleteObject:object];
	}
}

@end
