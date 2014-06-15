//
//  NSURL+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 27/05/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSURL+CoreDataKit.h"


NSString * const CDKSQLiteExtension	=	@"sqlite";


@implementation NSURL (CoreDataKit)

+ (instancetype)storeURLWithName:(NSString *)name {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *directoryURL = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
	return [directoryURL storeURLByAppendingName:name];
}

- (instancetype)storeURLByAppendingName:(NSString *)name {
	NSURL *url = [self URLByAppendingPathComponent:name isDirectory:NO];
	return [url URLByAppendingPathExtension:CDKSQLiteExtension];
}

@end
