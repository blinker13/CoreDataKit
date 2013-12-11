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

- (id)processedResult:(NSArray *)fetchedResults {
	NSString *key = [self.expressionDescription name];
	NSDictionary *result = [fetchedResults firstObject];
	return [result objectForKey:key];
}

@end
