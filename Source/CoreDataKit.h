//
//  CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <CoreDataStack/CDKStack.h>

#import <CoreDataStack/NSPersistentStore+CoreDataKit.h>
#import <CoreDataStack/NSManagedObjectContext+CoreDataKit.h>
#import <CoreDataStack/NSManagedObject+CoreDataKit.h>
#import <CoreDataStack/NSFetchRequest+CoreDataKit.h>

#if (TARGET_OS_MAC && TARGET_OS_IPHONE)
#import <CoreDataStack/NSFetchedResultsController+CoreDataKit.h>
#endif
