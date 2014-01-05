//
//  CDKAggregationObserver.h
//  CoreDataKit
//
//  Created by Felix Gabel on 02/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


typedef void (^ CDKObservationHandler)(id result, NSError *error);


@interface CDKAbstractObserver : NSObject

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) id	currentResult;


- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request;

- (void)startWithHandler:(CDKObservationHandler)handler;
- (void)stop;

- (BOOL)isRunning;

- (void)setNeedsReload;

@end
