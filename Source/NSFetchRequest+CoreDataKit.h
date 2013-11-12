//
//  NSFetchRequest+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 12/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSFetchRequest (CoreDataKit)

+ (instancetype)fetchRequestForKey:(NSString *)key withFunction:(NSString *)function resultType:(NSAttributeType)type;

@end
