//
//  NSExpressionDescription+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "NSExpressionDescription+CoreDataKit.h"


NSString *const CDKObjectIDKey	=	@"objectID";


@implementation NSExpressionDescription (CoreDataKit)

+ (instancetype)descriptionWithFunction:(NSString *)function forKey:(NSString *)key resultType:(NSAttributeType)type {
	NSAssert([key rangeOfString:@"."].location == NSNotFound, @"A keypath is not a valid option");
	
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:key];
	NSExpression *maxExpression = [NSExpression expressionForFunction:function arguments:@[keyExpression]];
	
	NSExpressionDescription *description = [[NSExpressionDescription alloc] init];
	[description setExpressionResultType:type];
	[description setExpression:maxExpression];
	[description setName:key];
	
	return description;
}

+ (instancetype)objectIDDescription {
	NSExpression *expression = [NSExpression expressionForEvaluatedObject];
	
	NSExpressionDescription *description = [[NSExpressionDescription alloc] init];
	[description setExpressionResultType:NSObjectIDAttributeType];
	[description setExpression:expression];
	[description setName:CDKObjectIDKey];

	return description;
}

@end
