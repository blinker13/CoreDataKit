//
//  NSFetchedResultsController+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import CoreData;


typedef void (^CDKMoveHandler)(id object, NSUInteger index);


@interface NSFetchedResultsController (CoreDataKit)

- (NSInteger)numberOfSections;
- (NSInteger)numberOfObjectsInSection:(NSInteger)section;
- (NSArray *)objectsForIndexPaths:(NSArray *)indexPaths;

- (NSString *)identifierForObjectAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForObjectWithIdentifier:(NSString *)identifier;

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex update:(CDKMoveHandler)handler;

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths;

@end
