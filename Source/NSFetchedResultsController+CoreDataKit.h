//
//  NSFetchedResultsController+CoreDataKit.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


typedef void (^CDKMoveHandler)(id object, NSUInteger index);


@interface NSFetchedResultsController (CoreDataKit)

- (NSInteger)numberOfObjectsInSection:(NSInteger)section;
- (NSArray *)objectsAtIndexPaths:(NSArray *)indexPaths;

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex update:(CDKMoveHandler)handler;

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath error:(NSError **)error;
- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths error:(NSError **)error;

@end
