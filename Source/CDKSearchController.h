//
//  CDKSearchController.h
//  CoreDataKit
//
//  Created by Felix Gabel on 05/01/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

@import CoreData;

@class CDKSearchController;


@protocol CDKSearchControllerDelegate <NSObject>

@optional
- (void)controllerWillChangeContent:(CDKSearchController *)controller;
- (void)controller:(CDKSearchController *)controller didFindObjectAtIndex:(NSUInteger)index;
- (void)controller:(CDKSearchController *)controller didFilterObjectAtIndex:(NSUInteger)index;
- (void)controllerDidChangeContent:(CDKSearchController *)controller;

@end


@interface CDKSearchController : NSObject

@property (nonatomic, weak) id<CDKSearchControllerDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic) NSUInteger	numberOfObjects;


- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request;
- (void)filterUsingPredicate:(NSPredicate *)predicate finished:(void (^)(NSArray *objects))handler;

- (id)objectAtIndex:(NSUInteger)index;

@end
