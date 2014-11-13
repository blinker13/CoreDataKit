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

- (NSURL *)objectURI {
	return [self.objectID URIRepresentation];
}

@end
