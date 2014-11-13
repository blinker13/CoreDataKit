//
//  NSURL+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;


@interface NSURL (CoreDataKit)

+ (instancetype)defaultStoreURL;
+ (instancetype)storeURLWithName:(NSString *)name;

- (instancetype)storeURLByAppendingName:(NSString *)name;

@end
