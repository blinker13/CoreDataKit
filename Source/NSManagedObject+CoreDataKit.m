//
//  NSManagedObject+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObject+CoreDataKit.h"
#import "NSExpressionDescription+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (NSString *)entityName {
	return NSStringFromClass(self);
}

+ (instancetype)insertInContext:(NSManagedObjectContext *)context {
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}


#pragma mark - attributes

+ (NSAttributeType)attributeTypeForKey:(NSString *)key inContext:(NSManagedObjectContext *)context {
	NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
	NSDictionary *attributes = [entity attributesByName];
	NSAttributeDescription *attribute = [attributes objectForKey:key];
	NSAssert(attribute, @"'%@' does not implement an attribute named '%@'.", NSStringFromClass(self), attribute);
	return [attribute attributeType];
}


#pragma mark - fetch request

+ (NSFetchRequest *)requestForAttribute:(NSString *)attribute ascending:(BOOL)ascending {
	NSFetchRequest *request = [self requestWithSortKey:attribute ascending:ascending];
	[request setResultType:NSDictionaryResultType];
	[request setPropertiesToFetch:@[attribute]];
	return request;
}

+ (NSFetchRequest *)requestWithSortKey:(NSString *)key ascending:(BOOL)ascending {
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSFetchRequest *request = [self request];
	[request setSortDescriptors:@[sort]];
	return request;
}

+ (NSFetchRequest *)requestWithPredicateFormat:(NSString *)format, ... {
	va_list list, listCopy;
	va_start(list, format);
	va_copy(listCopy, list);
	va_end(list);
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:format arguments:listCopy];
	
	va_end(listCopy);
	
	NSFetchRequest *request = [self request];
	[request setPredicate:predicate];
	return request;
}

+ (NSFetchRequest *)requestWithDescriptions:(NSArray *)descriptions {
	NSFetchRequest *request = [self request];
	[request setResultType:NSDictionaryResultType];
	[request setPropertiesToFetch:descriptions];
	return request;
}

+ (NSFetchRequest *)request {
	NSString *entityName = [self entityName];
	return [[NSFetchRequest alloc] initWithEntityName:entityName];
}


#pragma mark -

- (NSString *)stringID {
	NSManagedObjectID *objectID = [self objectID];
	NSURL *uri = [objectID URIRepresentation];
	return [uri absoluteString];
}

@end
