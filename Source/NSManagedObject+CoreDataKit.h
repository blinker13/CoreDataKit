//
//  NSManagedObject+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 08/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSManagedObject (CoreDataKit)

+ (NSString *)entityName;
+ (instancetype)insertInContext:(NSManagedObjectContext *)context;

+ (NSAttributeType)attributeTypeForKey:(NSString *)key inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestForAttribute:(NSString *)attribute ascending:(BOOL)ascending;
+ (NSFetchRequest *)requestWithSortKey:(NSString *)key ascending:(BOOL)ascending;
+ (NSFetchRequest *)requestWithPredicateFormat:(NSString *)format, ...;
+ (NSFetchRequest *)requestWithDescriptions:(NSArray *)descriptions;
+ (NSFetchRequest *)request;

- (NSString *)stringID;

@end
