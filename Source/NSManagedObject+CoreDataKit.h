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
+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;

+ (NSAttributeType)attributeTypeForKey:(NSString *)key inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)fetchRequestWithFunction:(NSString *)function forKey:(NSString *)key resultType:(NSAttributeType)type;
+ (NSFetchRequest *)fetchRequestWithSortKey:(NSString *)key ascending:(BOOL)ascending;
+ (NSFetchRequest *)fetchRequestWithPredicateFormat:(NSString *)format, ...;
+ (NSFetchRequest *)fetchRequest;

@end
