//
//  CDKSearchController.h
//  CoreDataKit
//
//  Created by Felix Gabel on 05/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;

@class CDKFilterController;


@protocol CDKFilterControllerDelegate <NSObject>

@optional
- (void)controllerWillChangeResults:(CDKFilterController *)controller;
- (void)controller:(CDKFilterController *)controller didInsertObject:(id)object atIndex:(NSUInteger)index;
- (void)controller:(CDKFilterController *)controller didRemoveObjectAtIndex:(NSUInteger)index;
- (void)controllerDidChangeResults:(CDKFilterController *)controller;

@end


@interface CDKFilterController : NSObject

@property (nonatomic, weak) id<CDKFilterControllerDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) NSUInteger	numberOfResults;
//@property (nonatomic, readonly) BOOL	is
@property (nonatomic) BOOL	shouldReturnAllWhenEmpty;


- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request NS_DESIGNATED_INITIALIZER;
- (void)filterUsingPredicate:(NSPredicate *)predicate finished:(void (^)(NSArray *objects))handler;

- (id)resultAtIndex:(NSUInteger)index;

@end
