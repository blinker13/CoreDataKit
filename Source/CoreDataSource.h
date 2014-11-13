//
//  CoreDataSource.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;
@import CoreData;

@class CoreDataSource;


@protocol CoreDataSourceDelegate <NSObject>

- (void)dataSourceWillChangeContent:(CoreDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(CoreDataSource *)dataSource;

- (void)dataSource:(CoreDataSource *)dataSource didInsertSection:(NSUInteger)section;
- (void)dataSource:(CoreDataSource *)dataSource didDeleteSection:(NSUInteger)section;

- (void)dataSource:(CoreDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CoreDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CoreDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CoreDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end


#pragma mark -

@interface CoreDataSource : NSObject

@property (nonatomic, weak) id<CoreDataSourceDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) NSString	*sectionKey;
@property (nonatomic, readonly) NSString	*cacheName;


- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults cacheName:(NSString *)cacheName NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context;
- (instancetype)initWithRequest:(NSFetchRequest *)request;


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section;

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface CoreDataSource (Subscripting)

- (id)objectForKeyedSubscript:(NSIndexPath *)key;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end


//#pragma mark -
//
//@interface CoreDataSource (Manipulation)
//
//- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
//- (void)deleteObject:(NSManagedObject *)object;
//
//- (void)save:(void (^)(NSError *error))handler;
//
//@end
