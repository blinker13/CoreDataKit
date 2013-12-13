//
//  CDKAggregationObserver.m
//  CoreDataKit
//
//  Created by Felix Gabel on 02/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKObserver.h"


@interface CDKObserver ()

@property (nonatomic, copy) CDKObservationHandler	handler;
@property (nonatomic, strong) id	unprocessedResult;

@property BOOL	isObservingChanges;
@property BOOL	isReloadingResult;

@end


#pragma mark -
@implementation CDKObserver

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request {
	if ((self = [super init])) {
		_context = context;
		_request = request;
	}
	return self;
}

- (void)dealloc {
	[self stop];
}


#pragma mark -

- (id)currentResult {
	return self.unprocessedResult;
}

- (void)startWithHandler:(CDKObservationHandler)handler {
	if (!self.isObservingChanges) {
		SEL action = @selector(evaluateChanges:);
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:action name:NSManagedObjectContextDidSaveNotification object:self.context];
		
		if ([self.request includesPendingChanges]) {
			[center addObserver:self selector:action name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
		}
		[self setIsObservingChanges:YES];
	}
	[self setUnprocessedResult:nil];
	[self setHandler:handler];
	
	[self.context performBlockAndWait:^{
		[self loadCurrentResult];
	}];
}

- (void)stop {
	if (self.isObservingChanges) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
		[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.context];
		
		[self setIsObservingChanges:NO];
	}
	[self setUnprocessedResult:nil];
}

- (BOOL)isRunning {
	return [self isObservingChanges];
}

- (void)setNeedsReload {
	if (!self.isReloadingResult && self.isObservingChanges) {
		[self.context performBlockAndWait:^{
			[self loadCurrentResult];
		}];
		[self setIsReloadingResult:YES];
	}
}


#pragma mark -

- (void)evaluateChanges:(NSNotification *)notification {
	//TODO: evaluate notification infos
	[self setNeedsReload];
}

- (void)loadCurrentResult {
	NSError *executionError = nil;
	NSArray *results = [self.context executeFetchRequest:self.request error:&executionError];
	
	if (self.handler && ![results isEqual:self.unprocessedResult]) {
		[self setUnprocessedResult:results];
		
		self.handler(self.currentResult, executionError);
	}
	[self setIsReloadingResult:NO];
}

@end
