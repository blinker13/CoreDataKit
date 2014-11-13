//
//  NSURL+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSURL+CoreDataKit.h"


@implementation NSURL (CoreDataKit)

+ (instancetype)defaultStoreURL {
	NSBundle *mainBundle = [NSBundle mainBundle];
	NSString *name = mainBundle.infoDictionary[(__bridge NSString *)kCFBundleExecutableKey];
	return [self storeURLWithName:name];
}

+ (instancetype)storeURLWithName:(NSString *)name {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSBundle *mainBundle = [NSBundle mainBundle];
	
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *url = [urls.firstObject URLByAppendingPathComponent:mainBundle.bundleIdentifier isDirectory:YES];
	return [url storeURLByAppendingName:name];
}

- (instancetype)storeURLByAppendingName:(NSString *)name {
	NSURL *url = [self URLByAppendingPathComponent:name isDirectory:NO];
	return [url URLByAppendingPathExtension:@"sqlite"];
}

@end
