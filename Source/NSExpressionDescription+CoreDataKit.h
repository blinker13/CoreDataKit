//
//  NSExpressionDescription+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface NSExpressionDescription (CoreDataKit)

- (instancetype)initWithFunction:(NSString *)function key:(NSString *)key resultType:(NSAttributeType)type;
- (instancetype)initWithResultType:(NSAttributeType)type;

@end
