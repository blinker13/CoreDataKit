//
//  NSManagedObjectContext+CDKSaveObserving.m
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObjectContext+CDKSaveObserving.h"


@implementation NSManagedObjectContext (CDKSaveObserving)

- (void)cdk_startObservingContext:(NSManagedObjectContext *)context {
	
	SEL action = @selector(cdk_mergeChangesFromNotification:);
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:action name:NSManagedObjectContextDidSaveNotification object:context];
}

- (void)cdk_stopObservingContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:NSManagedObjectContextDidSaveNotification object:context];
}

- (void)cdk_mergeChangesFromNotification:(NSNotification *)notification {
	
	[self performBlock:^{
		[self mergeChangesFromContextDidSaveNotification:notification];
	}];
}

@end
