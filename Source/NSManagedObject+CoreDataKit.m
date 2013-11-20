//
//  NSManagedObject+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSManagedObject+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (NSString *)entityName {
	return NSStringFromClass(self);
}

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context {
	NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
	return [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
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

+ (NSFetchRequest *)fetchRequestWithFunction:(NSString *)function forKey:(NSString *)key resultType:(NSAttributeType)type {
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:key];
	NSExpression *maxExpression = [NSExpression expressionForFunction:function arguments:@[keyExpression]];
	
	NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
	[expressionDescription setExpressionResultType:type];
	[expressionDescription setExpression:maxExpression];
	[expressionDescription setName:key];
	
	NSFetchRequest *request = [self fetchRequest];
	[request setPropertiesToFetch:@[expressionDescription]];
	[request setResultType:NSDictionaryResultType];
	return request;
}

+ (NSFetchRequest *)fetchRequestWithSortKey:(NSString *)key ascending:(BOOL)ascending {
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSFetchRequest *request = [self fetchRequest];
	[request setSortDescriptors:@[sort]];
	return request;
}

+ (NSFetchRequest *)fetchRequest {
	NSString *entityName = [self entityName];
	return [[NSFetchRequest alloc] initWithEntityName:entityName];
}

@end
