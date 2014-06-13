//
//  NSCoder+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 21/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSCoder+CoreDataKit.h"
#import "NSManagedObjectContext+CoreDataKit.h"
#import "CDKAssert.h"


@implementation NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)objv forKey:(NSString *)key {
	NSURL *objectURI = [objv.objectID URIRepresentation];
	[self encodeObject:objectURI forKey:key];
}

- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context {
	NSURL *objectURI = [self decodeObjectForKey:key];
	
	if (objectURI) {
		NSError *error = nil;
		NSManagedObjectID *objectID = [context objectIDForURI:objectURI];
		NSManagedObject *object = [context existingObjectWithID:objectID error:&error];
		CDKAssertError(error);
		return object;
	}
	return nil;
}

@end
