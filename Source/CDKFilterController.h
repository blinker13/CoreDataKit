//
//  CDKSearchController.h
//  CoreDataKit
//
//  Created by Felix Gabel on 05/01/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

@import CoreData;

@class CDKFilterController;


@protocol CDKFilterControllerDelegate <NSObject>

@optional
- (void)controllerWillChangeContent:(CDKFilterController *)controller;
- (void)controller:(CDKFilterController *)controller didInsertObjectAtIndex:(NSUInteger)index;
- (void)controller:(CDKFilterController *)controller didRemoveObjectAtIndex:(NSUInteger)index;
- (void)controllerDidChangeContent:(CDKFilterController *)controller;

@end


@interface CDKFilterController : NSObject

@property (nonatomic, weak) id<CDKFilterControllerDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) NSUInteger	numberOfObjects;

@property (nonatomic) BOOL	shouldReturnAllWhenEmpty;


- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request;
- (void)filterUsingPredicate:(NSPredicate *)predicate finished:(void (^)(NSArray *objects))handler;

- (id)objectAtIndex:(NSUInteger)index;

@end
