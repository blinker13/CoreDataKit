//
//  NSCoder+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSCoder+CoreDataKit.h"
#import "NSManagedObjectContext+CoreDataKit.h"


@implementation NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)object forKey:(NSString *)key {
	[self encodeObject:object forKey:key];
}

- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context {
	NSURL *objectURI = [self decodeObjectForKey:key];
	
	if (objectURI) {
		return [context managedObjectForObjectURI:objectURI];
	}
	return nil;
}

@end
