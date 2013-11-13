//
//  NSFetchedResultsController+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSFetchedResultsController+CoreDataKit.h"


@implementation NSFetchedResultsController (CoreDataKit)

- (NSInteger)numberOfObjectInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}


#pragma mark -

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex update:(CDKUpdateHandler)handler {
	NSMutableOrderedSet *objects = [[NSMutableOrderedSet alloc] initWithArray:self.fetchedObjects];
	NSIndexSet *indexes = [[NSIndexSet alloc] initWithIndex:index];
	[objects moveObjectsAtIndexes:indexes toIndex:newIndex];
	
	if (handler) {
		NSUInteger currentIndex = MIN(index, newIndex);
		NSUInteger endIndex = MAX(index, newIndex);
		
		__weak id<NSFetchedResultsControllerDelegate> delegate = self.delegate;
		[self setDelegate:nil];
		
		for (; currentIndex <= stop; currentIndex++) {
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

@end
