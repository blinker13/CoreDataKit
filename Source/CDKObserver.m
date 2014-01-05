//
//  CDKObserver.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKObserver.h"


@interface CDKObserver ()

@property (nonatomic) BOOL	shouldDelegateInserts;
@property (nonatomic) BOOL	shouldDelegateUpdates;
@property (nonatomic) BOOL	shouldDelegateDeletes;

@end


#pragma mark -
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

- (void)setDelegate:(id<CDKObserverDelegate>)delegate {
	if (delegate != self.delegate) {
		[self setShouldDelegateInserts:[delegate respondsToSelector:@selector(observer:didObserveInsert:)]];
		[self setShouldDelegateUpdates:[delegate respondsToSelector:@selector(observer:didObserveUpdate:)]];
		[self setShouldDelegateDeletes:[delegate respondsToSelector:@selector(observer:didObserveDelete:)]];
		_delegate = delegate;
	}
}

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
	
	if (self.shouldDelegateInserts) [self.delegate observer:self didObserveInsert:[info objectForKey:NSInsertedObjectsKey]];
	if (self.shouldDelegateUpdates) [self.delegate observer:self didObserveUpdate:[info objectForKey:NSUpdatedObjectsKey]];
	if (self.shouldDelegateDeletes) [self.delegate observer:self didObserveDelete:[info objectForKey:NSDeletedObjectsKey]];
}

@end
