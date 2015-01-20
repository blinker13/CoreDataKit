//
//  NSManagedObject+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSManagedObject+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (NSString *)entityName {
	NSString *name = NSStringFromClass(self);
	NSArray *nameParts = [name componentsSeparatedByString:@"."];
	return [nameParts lastObject];
}

+ (instancetype)insertInContext:(NSManagedObjectContext *)context {
	return [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
}


#pragma mark - fetch request

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

+ (NSFetchRequest *)request {
	NSString *entityName = [self entityName];
	return [[NSFetchRequest alloc] initWithEntityName:entityName];
}


#pragma mark -

- (NSURL *)objectURI {
	return [self.objectID URIRepresentation];
}

@end
