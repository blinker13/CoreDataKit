//
//  CDKObserver.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/12/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;

@class CDKObserver;


@protocol CDKObserverDelegate <NSObject>

- (void)observer:(CDKObserver *)observer didObserveInsert:(NSSet *)insertedObjects;
- (void)observer:(CDKObserver *)observer didObserveUpdate:(NSSet *)insertedObjects;
- (void)observer:(CDKObserver *)observer didObserveDelete:(NSSet *)insertedObjects;

@end



@interface CDKObserver : NSObject

@property (nonatomic, weak) id<CDKObserverDelegate>		delegate;
@property (nonatomic, readonly) NSManagedObjectContext	*context;

@property (nonatomic) BOOL	shouldIncludePendingChanges;


- (instancetype)initWithContext:(NSManagedObjectContext *)context;

@end
