//
//  XCTestCase+Fixtures.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XCTestCase+Fixtures.h"


@implementation XCTestCase (Fixtures)

- (NSManagedObjectModel *)fixtureModel {
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.felixgabel.CoreDataKitTests-iOS"];
	return [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
}

- (NSManagedObjectModel *)fixtureMergedModel {
	return [NSManagedObjectModel mergedModelFromBundles:nil];
}

- (CDKStack *)fixtureStackWithoutStore {
	return [[CDKStack alloc] initWithModel:self.fixtureModel];
}

- (CDKStack *)fixtureFullStack {
	CDKStack *stack = [self fixtureStackWithoutStore];
	[stack .coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
	return stack;
}

@end
