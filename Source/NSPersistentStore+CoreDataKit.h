//
//  NSPersistentStore+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


extern NSString * const CDKSQLiteExtension;


@interface NSPersistentStore (CoreDataKit)

@property (nonatomic, getter = isBackupEnabled) BOOL	backupEnabled;


+ (NSURL *)defaultDirectoryURL;
+ (NSURL *)defaultStoreURL;

@end
