//
//  NSExpressionDescription+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


extern NSString *const CDKObjectIDKey;


@interface NSExpressionDescription (CoreDataKit)

+ (instancetype)descriptionWithFunction:(NSString *)function forKey:(NSString *)key resultType:(NSAttributeType)type;
+ (instancetype)objectIDDescription;

@end
