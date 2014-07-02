//
//  CDKStackComponents.h
//  CoreDataKit
//
//  Created by Felix Gabel on 27/06/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface CDKStackComponents : NSObject

@property (nonatomic, strong) NSString		*configuration;
@property (nonatomic, strong) NSDictionary	*options;
@property (nonatomic, strong) NSString		*type;
@property (nonatomic, strong) NSURL			*URL;


- (instancetype)initWithURL:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end
