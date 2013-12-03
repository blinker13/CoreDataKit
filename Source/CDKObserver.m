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
@property (nonatomic, strong) id	currentResult;

@property BOOL	isObservingChanges;

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
	[self setCurrentResult:nil];
	[self setHandler:handler];
	[self loadCurrentResult];
}

- (void)stop {
	if (self.isObservingChanges) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center removeObserver:self name:NSManagedObjectContextObjectsDidChangeNotification object:self.context];
		[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:self.context];
		
		[self setIsObservingChanges:NO];
	}
	[self setCurrentResult:nil];
}

- (BOOL)isRunning {
	return [self isObservingChanges];
}

- (id)processedResult:(NSArray *)fetchedResults {
	return fetchedResults;
}


#pragma mark -

- (void)evaluateChanges:(NSNotification *)notification {
	[self loadCurrentResult];
}

- (void)loadCurrentResult {
	[self.context performBlock:^{
		NSError *aggregationError = nil;
		NSArray *results = [self.context executeFetchRequest:self.request error:&aggregationError];
		id result = [self processedResult:results];
		
		if (self.handler && ![result isEqual:self.currentResult]) {
			self.handler(result, aggregationError);
			[self setCurrentResult:result];
		}
	}];
}

@end
