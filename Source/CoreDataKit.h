//
//  CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <CoreDataKit/CDKStack.h>

#import <CoreDataKit/NSPersistentStore+CoreDataKit.h>
#import <CoreDataKit/NSManagedObjectModel+CoreDataKit.h>
#import <CoreDataKit/NSManagedObjectContext+CoreDataKit.h>
#import <CoreDataKit/NSManagedObject+CoreDataKit.h>
#import <CoreDataKit/NSFetchRequest+CoreDataKit.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <CoreDataKit/NSFetchedResultsController+CoreDataKit.h>
#endif
