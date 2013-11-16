//
//  NSManagedObjectModel+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 16/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObjectModel+CoreDataKit.h"


@implementation NSManagedObjectModel (CoreDataKit)

- (NSEntityDescription *)entityForClass:(Class)theClass {
	NSString *className = NSStringFromClass(theClass);
	
	for (NSEntityDescription *entity in self.entities) {
		if ([entity.managedObjectClassName isEqualToString:className]) {
			return entity;
		}
	}
	return nil;
}

@end
