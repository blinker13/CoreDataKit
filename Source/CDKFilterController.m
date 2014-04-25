//
//  CDKSearchController.m
//  CoreDataKit
//
//  Created by Felix Gabel on 05/01/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

#import "CDKFilterController.h"


typedef NS_OPTIONS(NSUInteger, CDKFilterCallbackMask) {
	CDKFilterCallbackDisabled		=	0 << 0,
	CDKFilterCallbackWillChange		=	1 << 0,
	CDKFilterCallbackInsertResult	=	1 << 1,
	CDKFilterCallbackRemoveResult	=	1 << 2,
	CDKFilterCallbackDidChange		=	1 << 3,
};


@interface CDKFilterController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController	*fetchedObjects;

@property (nonatomic, strong) NSArray		*currentResults;
@property (nonatomic, strong) NSPredicate	*currentFilter;
@property (nonatomic, strong) NSCache		*resultsCache;

@property (nonatomic) CDKFilterCallbackMask	callbackMask;

@end


#pragma mark -
@implementation CDKFilterController

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request {
	NSAssert(context, @"Invalid context: %@", context);
	NSAssert(request, @"Invalid request: %@", request);
	
	if ((self = [super init])) {
		_resultsCache = [[NSCache alloc] init];
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

- (void)setDelegate:(id<CDKFilterControllerDelegate>)delegate {
	if (delegate != self.delegate) {
		if ([delegate respondsToSelector:@selector(controllerWillChangeContent:)]) _callbackMask |= CDKFilterCallbackWillChange;
		if ([delegate respondsToSelector:@selector(controllerDidChangeContent:)]) _callbackMask |= CDKFilterCallbackDidChange;
		if ([delegate respondsToSelector:@selector(controller:didInsertObject:atIndex:)]) _callbackMask |= CDKFilterCallbackInsertResult;
		if ([delegate respondsToSelector:@selector(controller:didRemoveObjectAtIndex:)]) _callbackMask |= CDKFilterCallbackRemoveResult;
		_delegate = delegate;
	}
}

- (void)filterUsingPredicate:(NSPredicate *)predicate finished:(void (^)(NSArray *objects))handler {
	
	[self.context performBlock:^{
		[self setCurrentFilter:predicate];
		
		NSArray *results = [self filteredObjectsUsingPredicate:predicate];
//		[self processSearchResults:results];
		[self setCurrentResults:results];
		
		if (handler) {
			handler(results);
		}
	}];
}

- (NSUInteger)numberOfResults {
	return [self.currentResults count];
}

- (id)resultAtIndex:(NSUInteger)index {
	return [self.currentResults objectAtIndex:index];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self resetFilteredObjectsCache:nil];
}


#pragma mark - private methods

- (NSArray *)filteredObjectsUsingPredicate:(NSPredicate *)predicate {
	NSArray *filteredObjects = nil;
	
	if (predicate) {
		filteredObjects = [self.resultsCache objectForKey:predicate];
		
		if (!filteredObjects) {
			NSArray *fetchedObjects = [self.fetchedObjects fetchedObjects];
			filteredObjects = [fetchedObjects filteredArrayUsingPredicate:predicate];
			
			if ([filteredObjects count] == 0 && self.shouldReturnAllWhenEmpty) {
				filteredObjects = fetchedObjects;
			}
			[self.resultsCache setObject:filteredObjects forKey:predicate];
		}
		
	} else {
		 filteredObjects = [self.fetchedObjects fetchedObjects];
	}
	return filteredObjects;
}

- (void)processSearchResults:(NSArray *)results {
	BOOL shouldCallBack = (self.callbackMask != CDKFilterCallbackDisabled);
	
	if (shouldCallBack && ![self.currentResults isEqualToArray:results]) {
//		NSIndexSet *inserts = [self processInsertedResults:results];
//		NSIndexSet *removes = [self processRemovedResults:results];
//		
		[self setCurrentResults:results];
//		[self sendDelegateCallbackWithInserts:inserts removes:removes];
	}
}

- (void)sendDelegateCallbackWithInserts:(NSIndexSet *)inserts removes:(NSIndexSet *)removes {
	
	if ([inserts count] || [removes count]) {
		if (self.callbackMask | CDKFilterCallbackWillChange) {
			[self.delegate controllerWillChangeResults:self];
		}
		if (self.callbackMask | CDKFilterCallbackInsertResult) {
			
		}
	}
}

//- (NSIndexSet *)processInsertedResults:(NSArray *)results {
//	if (self.currentResults && (self.callbackMask & CDKFilterCallbackInsertResult)) {
////		return [results ]
//		
//		[results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//			if ([self.currentResults indexOfObject:obj] == NSNotFound) {
//				[self.delegate controller:self didInsertObject:obj atIndex:idx];
//			}
//		}];
//	}
//	return nil;
//}
//
//- (NSIndexSet *)processRemovedResults:(NSArray *)results {
//	if (self.callbackMask & CDKFilterCallbackRemoveResult) {
//		[self.currentResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//			if ([results indexOfObject:obj] == NSNotFound) {
//				[self.delegate controller:self didRemoveObjectAtIndex:idx];
//			}
//		}];
//	}
//}

- (void)resetFilteredObjectsCache:(NSNotification *)notification {
	[self.resultsCache removeAllObjects];
	[self filterUsingPredicate:self.currentFilter finished:nil];
}

@end
