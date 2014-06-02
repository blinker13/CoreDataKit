//
//  NSURL+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 27/05/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

@import CoreData;


@interface NSURL (CoreDataKit)

+ (instancetype)defaultStoreURL;
+ (instancetype)defaultStoreURLWithName:(NSString *)name;

- (instancetype)storeURLByAppendingName:(NSString *)name;

@end
