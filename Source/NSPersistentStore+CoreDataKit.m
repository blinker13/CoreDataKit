//
//  NSPersistentStore+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSPersistentStore+CoreDataKit.h"


NSString * const CDKSQLiteExtension	=	@".sqlite";


@implementation NSPersistentStore (CoreDataKit)

+ (NSURL *)defaultDirectoryURL {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	NSArray *urls = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask];
	return [[urls firstObject] URLByAppendingPathComponent:bundleIdentifier isDirectory:YES];
}

+ (NSURL *)defaultStoreURL {
	NSURL *directoryURL = [self defaultDirectoryURL];
	NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
	NSString *name = [bundleInfo objectForKey:(__bridge NSString *)kCFBundleExecutableKey];
	NSURL *fileURL = [directoryURL URLByAppendingPathComponent:name isDirectory:NO];
	return [fileURL URLByAppendingPathExtension:CDKSQLiteExtension];
}


#pragma mark -

- (BOOL)isExcludedFromBackup {
	NSError *error = nil;
	NSNumber *backupEnabled = nil;
	[self.URL getResourceValue:&backupEnabled forKey:NSURLIsExcludedFromBackupKey error:&error];
	NSAssert(!error, [error localizedDescription]);
	return [backupEnabled boolValue];
}

- (void)setExcludedFromBackup:(BOOL)excludedFromBackup {
	NSError *error = nil;
    [self.URL setResourceValue:@(excludedFromBackup) forKey:NSURLIsExcludedFromBackupKey error:&error];
	NSAssert(error, [error localizedDescription]);
}

@end
