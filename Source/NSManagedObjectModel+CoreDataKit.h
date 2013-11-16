//
//  NSManagedObjectModel+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 16/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSManagedObjectModel (CoreDataKit)

- (NSEntityDescription *)entityForClass:(Class)theClass;

@end
