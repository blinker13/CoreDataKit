//
//  CDKContextObserver.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;

@class CDKContextObserver;


@protocol CDKObserverDelegate <NSObject>

- (void)observer:(CDKContextObserver *)observer didObserveInsert:(NSSet *)insertedObjects;
- (void)observer:(CDKContextObserver *)observer didObserveUpdate:(NSSet *)insertedObjects;
- (void)observer:(CDKContextObserver *)observer didObserveDelete:(NSSet *)insertedObjects;

@end


@interface CDKContextObserver : NSObject

@property (nonatomic, weak) id<CDKObserverDelegate>		delegate;
@property (nonatomic, readonly) NSManagedObjectContext	*context;

@property (nonatomic) BOOL	shouldIncludePendingChanges;


- (instancetype)initWithContext:(NSManagedObjectContext *)context;

@end
