//
//  NSManagedObjectContext+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 24/10/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObjectContext+CoreDataKit.h"


@implementation NSManagedObjectContext (CoreDataKit)

- (void)startMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context {
	SEL action = @selector(mergeChangesFromContextDidSaveNotification:);
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:context selector:action name:NSManagedObjectContextDidSaveNotification object:self];
}

- (void)stopMergingSaveNotificationsIntoContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:context name:NSManagedObjectContextDidSaveNotification object:self];
}


#pragma mark -

- (NSUInteger)numberOfObjects:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate error:(NSError **)error {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setPredicate:predicate];
	[request setEntity:entity];
	
	return [self countForFetchRequest:request error:error];
}

@end
