//
//  NSPersistentStore+CoreDataKit.m
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "NSPersistentStore+CoreDataKit.h"
#import "CDKDefines.h"


@implementation NSPersistentStore (CoreDataKit)

- (BOOL)shouldExcludeFromBackup {
	NSError *error = nil;
	NSNumber *backupEnabled = nil;
	
	[self.URL getResourceValue:&backupEnabled forKey:NSURLIsExcludedFromBackupKey error:&error];
	CDKAssertError(error);
	
	return [backupEnabled boolValue];
}

- (void)setShouldExcludeFromBackup:(BOOL)shouldExcludeFromBackup {
	NSNumber *value = @(shouldExcludeFromBackup);
	NSError *error = nil;
	
    [self.URL setResourceValue:value forKey:NSURLIsExcludedFromBackupKey error:&error];
	CDKAssertError(error);
}

@end
