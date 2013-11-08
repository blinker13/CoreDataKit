//
//  NSManagedObject+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObject+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context {
	NSEntityDescription *entity = [self entityDescriptionInContext:context];
	return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context {
	NSManagedObjectModel *model = [context.persistentStoreCoordinator managedObjectModel];
	NSDictionary *entitiesByName = [model entitiesByName];
	NSString *name = NSStringFromClass([self class]);
	return [entitiesByName objectForKey:name];
}

@end
