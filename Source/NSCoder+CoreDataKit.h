//
//  NSCoder+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 21/02/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)objv forKey:(NSString *)key;
- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context;

@end
