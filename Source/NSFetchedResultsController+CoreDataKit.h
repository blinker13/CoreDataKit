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

- (NSInteger)numberOfSections;
- (NSInteger)numberOfObjectsInSection:(NSInteger)section;
- (NSArray *)objectsForIndexPaths:(NSArray *)indexPaths;

- (NSString *)identifierForObjectAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForObjectWithIdentifier:(NSString *)identifier;

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)newIndex update:(CDKMoveHandler)handler;

- (BOOL)deleteObjectAtIndexPath:(NSIndexPath *)indexPath error:(NSError **)error;
- (BOOL)deleteObjectsAtIndexPaths:(NSArray *)indexPaths error:(NSError **)error;

@end
