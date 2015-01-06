//
//  CDKDataSource.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;
@import CoreData;

@class CDKDataSource;


@protocol CDKDataSourceDelegate <NSObject>

- (void)dataSourceWillChangeContent:(CDKDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(CDKDataSource *)dataSource;

- (void)dataSource:(CDKDataSource *)dataSource didInsertSection:(NSUInteger)section;
- (void)dataSource:(CDKDataSource *)dataSource didDeleteSection:(NSUInteger)section;

- (void)dataSource:(CDKDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end


#pragma mark -

@interface CDKDataSource : NSObject

@property (nonatomic, weak) id<CDKDataSourceDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) NSString	*sectionKey;
@property (nonatomic, readonly) NSString	*cacheName;


- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults cacheName:(NSString *)cacheName NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context;


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section;

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface CDKDataSource (Subscripting)

- (id)objectForKeyedSubscript:(NSIndexPath *)key;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end


//#pragma mark -
//
//@interface CDKDataSource (Manipulation)
//
//- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;
//- (void)deleteObject:(NSManagedObject *)object;
//
//- (void)save:(void (^)(NSError *error))handler;
//
//@end
