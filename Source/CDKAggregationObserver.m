//
//  CDKAggregationObserver.m
//  CoreDataKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKAggregationObserver.h"


@interface CDKAggregationObserver ()

@property (nonatomic, strong) NSExpressionDescription *expressionDescription;

@end


#pragma mark -
@implementation CDKAggregationObserver

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request {
	NSAssert([request.propertiesToFetch count] == 1, @"The request should include one Expression Description");
	
	if ((self = [super initWithContext:context request:request])) {
		_expressionDescription = [request.propertiesToFetch firstObject];
		NSAssert([_expressionDescription class] == [NSExpressionDescription class], @"Request should include a NSExpressionDescription");
	}
	return self;
}

- (id)currentResult {
	NSArray *result = [super currentResult];
	NSString *key = [self.expressionDescription name];
	NSDictionary *resultWrapper = [result firstObject];
	return [resultWrapper objectForKey:key];
}

@end
