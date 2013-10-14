//
//  CDKObjectsController.m
//  CoreDataKit
//
//  Created by Felix Gabel on 8/5/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import "CDKObjectsController.h"
#import "CDKStack.h"


@interface CDKObjectsController ()

@property (nonatomic, strong) NSFetchedResultsController	*fetchedObjects;

@end


#pragma mark -
@implementation CDKObjectsController

- (instancetype)initWithContext:(NSManagedObjectContext *)context entity:(NSEntityDescription *)entity {
	NSAssert(context, @"A valid managed object context is needed");
	NSAssert(entity, @"A valid entity description is needed");
	
	if ((self = [super init])) {
		_context = context;
		_entity = entity;
		
		_returnsObjectsAsFaults = YES;
		_includesPendingChanges = YES;
		_includesPropertyValues = YES;
		_includesSubentities = YES;
	}
	return self;
}

- (instancetype)init {
	return [self initWithContext:nil entity:nil];
}


#pragma mark -

- (void)fetch:(NSError **)error {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setRelationshipKeyPathsForPrefetching:self.relationshipKeyPathsForPrefetching];
	[request setReturnsDistinctResults:self.returnsObjectsAsFaults];
	[request setIncludesPendingChanges:self.includesPendingChanges];
	[request setIncludesPropertyValues:self.includesPropertyValues];
	[request setIncludesSubentities:self.includesSubentities];
	[request setPropertiesToFetch:self.propertiesToFetch];
	[request setSortDescriptors:self.sortDescriptions];
	[request setFetchBatchSize:self.fetchBatchSize];
	[request setFetchOffset:self.fetchOffset];
	[request setFetchLimit:self.fetchLimit];
	[request setPredicate:self.predicate];
	[request setEntity:self.entity];
	
	NSFetchedResultsController *entities = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.context sectionNameKeyPath:self.sectionNameKeyPath cacheName:self.cacheName];
	
	if (![entities performFetch:error]) {
		entities = nil;
	}
	[self setFetchedObjects:entities];
	[entities setDelegate:self];
}

- (id)insertNewObject:(NSDictionary *)infos {
	id object = [[NSManagedObject alloc] initWithEntity:self.entity insertIntoManagedObjectContext:self.context];
	[object setValuesForKeysWithDictionary:infos];
	return object;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
	return [self.fetchedObjects objectAtIndexPath:indexPath];
}

- (void)deleteObjectAtIndexPath:(NSIndexPath *)indexPath {
	id object = [self.fetchedObjects objectAtIndexPath:indexPath];
	[self.context deleteObject:object];
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)section {
	NSArray *sections = [self.fetchedObjects sections];
	id<NSFetchedResultsSectionInfo> info = [sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (NSInteger)numberOfSections {
	return [[self.fetchedObjects sections] count];
}

@end
