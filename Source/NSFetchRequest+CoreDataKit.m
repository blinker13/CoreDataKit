//
//  NSFetchRequest+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 12/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSFetchRequest+CoreDataKit.h"


@implementation NSFetchRequest (CoreDataKit)

+ (instancetype)fetchRequestWithFunction:(NSString *)function forKey:(NSString *)key resultType:(NSAttributeType)type {
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:key];
	NSExpression *maxExpression = [NSExpression expressionForFunction:function arguments:@[keyExpression]];
	
	NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
	[expressionDescription setExpressionResultType:type];
	[expressionDescription setExpression:maxExpression];
	[expressionDescription setName:key];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setPropertiesToFetch:@[expressionDescription]];
	[request setResultType:NSDictionaryResultType];
	return request;
}

+ (instancetype)fetchRequestWithEntity:(NSEntityDescription *)entity sortDescriptor:(NSSortDescriptor *)sortDescriptor {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setSortDescriptors:@[sortDescriptor]];
	[request setEntity:entity];
	return request;
}

+ (instancetype)fetchRequestWithEntity:(NSEntityDescription *)entity predicate:(NSPredicate *)predicate {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setPredicate:predicate];
	[request setEntity:entity];
	return request;
}

@end
