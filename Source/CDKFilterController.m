//
//  CDKSearchController.m
//  CoreDataKit
//
//  Created by Felix Gabel on 05/01/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

#import "CDKFilterController.h"


#pragma mark -
@interface CDKFilterController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController	*fetchedObjects;

@property (nonatomic, strong) NSCache		*filteredObjectsCache;
@property (nonatomic, strong) NSArray		*filteredObjects;
@property (nonatomic, strong) NSPredicate	*currentFilter;

@end


#pragma mark -
@implementation CDKFilterController

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request {
	NSAssert(context, @"Invalid context in CDKSearchController");
	NSAssert(request, @"Invalid request in CDKSearchController");
	
	if ((self = [super init])) {
		_filteredObjectsCache = [[NSCache alloc] init];
		_context = context;
		_request = request;
		
		SEL action = @selector(resetFilteredObjectsCache:);
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:action name:NSManagedObjectContextDidSaveNotification object:context];
	}
	return self;
}

- (void)dealloc {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.context];
}


#pragma mark -

- (NSUInteger)numberOfObjects {
	return [self.filteredObjects count];
}

- (id)objectAtIndex:(NSUInteger)index {
	return [self.filteredObjects objectAtIndex:index];
}

- (void)filterUsingPredicate:(NSPredicate *)predicate finished:(void (^)(NSArray *objects))handler {
	
	[self.context performBlock:^{
		NSArray *searchedObjects = [self filteredObjectsUsingPredicate:predicate];
		[self processSearchChanges:searchedObjects];
		[self setFilteredObjects:searchedObjects];
		[self setCurrentFilter:predicate];
		
		if (handler) {
			handler(searchedObjects);
		}
	}];
}

- (NSFetchedResultsController *)fetchedObjects {
	if (!_fetchedObjects) {
		_fetchedObjects = [[NSFetchedResultsController alloc] initWithFetchRequest:self.request managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
		[_fetchedObjects setDelegate:self];
		
		NSError *error = nil;
		[_fetchedObjects performFetch:&error];
		NSAssert(!error, [error localizedDescription]);
	}
	return _fetchedObjects;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self resetFilteredObjectsCache:nil];
}


#pragma mark - private methods

- (NSArray *)filteredObjectsUsingPredicate:(NSPredicate *)predicate {
	NSArray *filteredObjects = [self.filteredObjectsCache objectForKey:predicate];
	
	if (!filteredObjects) {
		NSArray *fetchedObjects = [self.fetchedObjects fetchedObjects];
		filteredObjects = [fetchedObjects filteredArrayUsingPredicate:predicate];
		[self.filteredObjectsCache setObject:filteredObjects forKey:predicate];
	}
	return filteredObjects;
}

- (void)processSearchChanges:(NSArray *)searchedObjects {
	if (![self.filteredObjects isEqualToArray:searchedObjects]) {
		NSArray *filteredObjects = [self filteredObjects];
		
		//TODO: implement delegate calls
	}
}

- (void)resetFilteredObjectsCache:(NSNotification *)notification {
	[self.filteredObjectsCache removeAllObjects];
	[self filterUsingPredicate:self.currentFilter finished:nil];
}

@end
