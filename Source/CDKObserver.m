//
//  CDKObserver.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKObserver.h"


@implementation CDKObserver

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
	if ((self = [super init])) {
		_context = context;
		
		SEL selector = @selector(processChangeNotification:);
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:selector name:NSManagedObjectContextDidSaveNotification object:_context];
	}
	return self;
}

- (instancetype)init {
	return [self initWithContext:nil];
}

- (void)dealloc {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
	[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.context];
}


#pragma mark -

- (void)setShouldIncludePendingChanges:(BOOL)shouldIncludePendingChanges {
	if (shouldIncludePendingChanges != self.shouldIncludePendingChanges) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		
		if (shouldIncludePendingChanges) {
			SEL selector = @selector(processChangeNotification:);
			[center addObserver:self selector:selector name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
			
		} else {
			[center removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
		}
		_shouldIncludePendingChanges = shouldIncludePendingChanges;
	}
}


#pragma mark - private methods

- (void)processChangeNotification:(NSNotification *)notification {
	NSDictionary *info = [notification userInfo];
	[self delegateInsertedObjects:info];
	[self delegateUpdatedObjects:info];
	[self delegateDeletedObjects:info];
}

- (void)delegateInsertedObjects:(NSDictionary *)userInfo {
	if ([self.delegate respondsToSelector:@selector(observer:didObserveInsert:)]) {
		NSSet *objects = [userInfo objectForKey:NSInsertedObjectsKey];
		[self.delegate observer:self didObserveInsert:objects];
	}
}

- (void)delegateUpdatedObjects:(NSDictionary *)userInfo {
	if ([self.delegate respondsToSelector:@selector(observer:didObserveInsert:)]) {
		NSSet *objects = [userInfo objectForKey:NSUpdatedObjectsKey];
		[self.delegate observer:self didObserveUpdate:objects];
	}
}

- (void)delegateDeletedObjects:(NSDictionary *)userInfo {
	if ([self.delegate respondsToSelector:@selector(observer:didObserveInsert:)]) {
		NSSet *objects = [userInfo objectForKey:NSDeletedObjectsKey];
		[self.delegate observer:self didObserveDelete:objects];
	}
}

@end
