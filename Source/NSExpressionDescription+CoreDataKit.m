//
//  NSExpressionDescription+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSExpressionDescription+CoreDataKit.h"


@implementation NSExpressionDescription (CoreDataKit)

- (instancetype)initWithFunction:(NSString *)function key:(NSString *)key resultType:(NSAttributeType)type {
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:key];
	
	typeof(self) this = [self initWithResultType:type];
	this.expression = [NSExpression expressionForFunction:function arguments:@[keyExpression]];
	this.name = key;
	return this;
}

- (instancetype)initWithResultType:(NSAttributeType)type {
	typeof(self) this = [self init];
	this.expressionResultType = type;
	
	if (type == NSObjectIDAttributeType) {
		this.expression = [NSExpression expressionForEvaluatedObject];
		this.name = @"objectID";
	}
	
	return this;
}

@end
