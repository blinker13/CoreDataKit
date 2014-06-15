//
//  NSURL+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 27/05/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface NSURL (CoreDataKit)

+ (instancetype)storeURLWithName:(NSString *)name;
- (instancetype)storeURLByAppendingName:(NSString *)name;

@end
