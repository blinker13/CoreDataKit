//
//  CDKStackComponents.m
//  CoreDataKit
//
//  Created by Felix Gabel on 27/06/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "CDKStackComponents.h"
#import "NSURL+CoreDataKit.h"


@implementation CDKStackComponents

- (instancetype)initWithURL:(NSURL *)url {
	NSAssert(url, @"A stack must be initialized with a valid URL: %@", url);
	
	if ((self = [super init])) {
		_options = @{ NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES };
		_configuration = nil;
		_URL =  url;
	}
	return self;
}

- (instancetype)init {
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *infos = [bundle infoDictionary];
	NSString *name = [infos objectForKey:(__bridge NSString *)kCFBundleExecutableKey];
	NSURL *url =  [NSURL URLWithStoreName:name];
	return [self initWithURL:url];
}

@end
