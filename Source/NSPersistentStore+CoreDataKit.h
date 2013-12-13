//
//  NSPersistentStore+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSPersistentStore (CoreDataKit)

@property (nonatomic, getter = isExcludedFromBackup) BOOL	excludedFromBackup;

@end
