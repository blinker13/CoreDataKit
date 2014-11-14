//
//  CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/26/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import Foundation;
@import CoreData;


#import <CoreDataKit/CDKStack.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <CoreDataKit/CDKDataSource.h>
#endif


#import <CoreDataKit/NSCoder+CoreDataKit.h>
#import <CoreDataKit/NSExpressionDescription+CoreDataKit.h>
#import <CoreDataKit/NSManagedObjectContext+CoreDataKit.h>
#import <CoreDataKit/NSManagedObject+CoreDataKit.h>
#import <CoreDataKit/NSURL+CoreDataKit.h>
