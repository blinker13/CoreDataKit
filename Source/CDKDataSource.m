//
//  CDKDataSource.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "CDKDataSource.h"


@interface CDKDataSource () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController	*results;

@end


@implementation CDKDataSource

- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults cacheName:(NSString *)cacheName {
	if ((self = [super init])) {
		
		if (shouldSectionResults) {
			NSSortDescriptor *sortDescriptor = [request.sortDescriptors firstObject];
			_sectionKey = [sortDescriptor key];
		}
		
		_cacheName = cacheName;
		_request = request;
		_context = context;
	}
	return self;
}

- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults {
	return [self initWithRequest:request context:context shouldSectionResults:shouldSectionResults cacheName:nil];
}

- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context {
	return [self initWithRequest:request context:context shouldSectionResults:NO];
}

- (instancetype)initWithRequest:(NSFetchRequest *)request {
	NSManagedObjectContext *context = nil;//TODO: get shared stack context
	return [self initWithRequest:request context:context];
}


#pragma mark -

- (NSUInteger)numberOfSections {
	return [self.results.sections count];
}

- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [self.results.sections objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object {
	return [self.results indexPathForObject:object];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
	return [self.results objectAtIndexPath:indexPath];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.delegate dataSourceWillChangeContent:self];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	switch (type) {
		case NSFetchedResultsChangeInsert: [self.delegate dataSource:self didInsertObject:anObject atIndexPath:newIndexPath]; break;
		case NSFetchedResultsChangeDelete: [self.delegate dataSource:self didDeleteObject:anObject atIndexPath:indexPath]; break;
		case NSFetchedResultsChangeUpdate: [self.delegate dataSource:self didUpdateObject:anObject atIndexPath:indexPath]; break;
		case NSFetchedResultsChangeMove:   [self.delegate dataSource:self didMoveObject:anObject fromIndexPath:indexPath toIndexPath:newIndexPath]; break;
		default: break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	
	switch (type) {
		case NSFetchedResultsChangeInsert: [self.delegate dataSource:self didInsertSection:sectionIndex]; break;
		case NSFetchedResultsChangeDelete: [self.delegate dataSource:self didDeleteSection:sectionIndex]; break;
		default: break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.delegate dataSourceDidChangeContent:self];
}


#pragma mark - private

- (NSFetchedResultsController *)results {
	if (!_results) {
		_results = [[NSFetchedResultsController alloc] initWithFetchRequest:self.request managedObjectContext:self.context sectionNameKeyPath:self.sectionKey cacheName:nil];
		[_results setDelegate:self];
		
		NSError *error = nil;
		[_results performFetch:&error];
		NSAssert(!error, error.localizedDescription);
	}
	return _results;
}

@end


#pragma mark -

@implementation CDKDataSource (Subscripting)

- (id)objectForKeyedSubscript:(NSIndexPath *)indexPath {
	return [self objectAtIndexPath:indexPath];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
	return self.results.fetchedObjects[idx];
}

@end

//
//#pragma mark -
//
//@interface CDKDataSource (Manipulation)
//
//- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath {
//	NSManagedObject *obejct = [self objectAtIndexPath:indexPath];
//	[self deleteObject:object];
//}
//
//- (void)deleteObject:(NSManagedObject *)object {
//	
//}
//
//- (void)save:(void (^)(NSError *error))handler {
//	
//}
//
//@end
