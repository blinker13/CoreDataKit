//
//  NSPersistentStore+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSPersistentStore+CoreDataKit.h"


@implementation NSPersistentStore (CoreDataKit)

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
