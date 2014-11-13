//
//  NSManagedObject+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface NSManagedObject (CoreDataKit)

@property (nonatomic, readonly) NSURL	*objectURI;


+ (NSString *)entityName;

@end
