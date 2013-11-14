//
//  NSFetchedResultsController+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSFetchedResultsController+CoreDataKit.h"


@implementation NSFetchedResultsController (CoreDataKit)

- (NSInteger)numberOfObjectsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (NSArray *)objectsAtIndexPaths:(NSArray *)indexPaths {
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	
	for (NSIndexPath *indexPath in indexPaths) {
		NSManagedObject *object = [self objectAtIndexPath:indexPath];
		[objects addObject:object];
	}
	return objects;
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
	for (NSManagedObject *object in [self objectsAtIndexPaths:indexPaths]) {
		[self.managedObjectContext deleteObject:object];
	}
}

@end
