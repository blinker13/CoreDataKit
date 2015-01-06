//
//  NSCoder+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;
@import CoreData;


@interface NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)object forKey:(NSString *)key;
- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context;

@end
