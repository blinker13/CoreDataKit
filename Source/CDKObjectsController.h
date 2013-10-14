//
//  CDKObjectsController.h
//  CoreDataKit
//
//  Created by Felix Gabel on 8/5/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


@interface CDKObjectsController : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSEntityDescription		*entity;

@property (nonatomic, strong) NSArray		*relationshipKeyPathsForPrefetching;
@property (nonatomic, strong) NSArray		*propertiesToFetch;
@property (nonatomic, strong) NSArray		*sortDescriptions;
@property (nonatomic, strong) NSString		*sectionNameKeyPath;
@property (nonatomic, strong) NSString		*cacheName;
@property (nonatomic, strong) NSPredicate	*predicate;

@property (nonatomic) NSUInteger	fetchBatchSize;
@property (nonatomic) NSUInteger	fetchOffset;
@property (nonatomic) NSUInteger	fetchLimit;

@property (nonatomic) BOOL	returnsObjectsAsFaults;
@property (nonatomic) BOOL	includesPendingChanges;
@property (nonatomic) BOOL	includesPropertyValues;
@property (nonatomic) BOOL	includesSubentities;


- (instancetype)initWithContext:(NSManagedObjectContext *)context entity:(NSEntityDescription *)entity;

- (void)fetch:(NSError **)error;

- (id)insertNewObject:(NSDictionary *)infos;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfObjectsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end
