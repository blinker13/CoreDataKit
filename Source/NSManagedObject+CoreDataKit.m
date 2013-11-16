//
//  NSManagedObject+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObject+CoreDataKit.h"
#import "NSManagedObjectModel+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context {
	NSEntityDescription *entity = [self entityDescriptionInContext:context];
	return [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context {
	NSManagedObjectModel *model = [context.persistentStoreCoordinator managedObjectModel];
	return [model entityForClass:[self class]];
}

+ (NSAttributeType)attributeTypeForKey:(NSString *)key inContext:(NSManagedObjectContext *)context {
	NSEntityDescription *entity = [self entityDescriptionInContext:context];
	NSDictionary *attributes = [entity attributesByName];
	NSAttributeDescription *attribute = [attributes objectForKey:key];
	NSAssert(attribute, @"'%@' does not implement an attribute named '%@'.", NSStringFromClass(self), attribute);
	return [attribute attributeType];
}

@end
