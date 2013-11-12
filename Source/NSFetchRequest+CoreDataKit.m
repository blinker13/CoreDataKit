//
//  NSFetchRequest+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 12/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSFetchRequest+CoreDataKit.h"


@implementation NSFetchRequest (CoreDataKit)

+ (instancetype)fetchRequestForKey:(NSString *)key withFunction:(NSString *)function resultType:(NSAttributeType)type {
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

@end
