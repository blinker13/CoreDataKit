//
//  CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import <CoreDataKit/CDKAssert.h>

#import <CoreDataKit/CDKStack.h>
#import <CoreDataKit/CDKContextObserver.h>

#import <CoreDataKit/NSCoder+CoreDataKit.h>
#import <CoreDataKit/NSExpressionDescription+CoreDataKit.h>
#import <CoreDataKit/NSManagedObjectContext+CoreDataKit.h>
#import <CoreDataKit/NSManagedObject+CoreDataKit.h>
#import <CoreDataKit/NSURL+CoreDataKit.h>


#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import <CoreDataKit/CDKFilterController.h>
#import <CoreDataKit/NSFetchedResultsController+CoreDataKit.h>

#endif
