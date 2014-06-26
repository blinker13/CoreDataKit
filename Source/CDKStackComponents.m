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

- (instancetype)initWithModel:(NSManagedObjectModel *)model {
	NSAssert(model, @"A stack must be initialized with a valid managed object model: %@", model);
	
	if ((self = [super init])) {
		NSBundle *bundle = [NSBundle mainBundle];
		NSDictionary *infos = [bundle infoDictionary];
		NSString *name = [infos objectForKey:(__bridge NSString *)kCFBundleExecutableKey];
		
		_URL =  [NSURL URLWithStoreName:name];
		_options = @{ NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES };
		_configuration = nil;
		_model = model;
	}
	return self;
}

- (instancetype)init {
	NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
	return [self initWithModel:model];
}

@end
