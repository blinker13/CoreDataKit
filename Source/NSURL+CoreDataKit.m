//
//  NSURL+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 27/05/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

#import "NSURL+CoreDataKit.h"
#import "CDKDefines.h"


NSString * const CDKSQLiteExtension	=	@"sqlite";


@implementation NSURL (CoreDataKit)

+ (instancetype)defaultStoreURLWithName:(NSString *)name {
	NSString *storeName = name ?: CDKDefaultStoreName();
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	NSURL *directoryURL = [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
	NSURL *fileURL = [directoryURL URLByAppendingPathComponent:storeName isDirectory:NO];
	return [fileURL URLByAppendingPathExtension:CDKSQLiteExtension];
}

@end
