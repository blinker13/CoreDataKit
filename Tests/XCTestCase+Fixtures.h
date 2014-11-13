//
//  XCTestCase+Fixtures.h
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreDataKit;
@import XCTest;


@interface XCTestCase (Fixtures)

@property (nonatomic, readonly) NSManagedObjectModel	*fixtureModel;
@property (nonatomic, readonly) NSManagedObjectModel	*fixtureMergedModel;

@property (nonatomic, readonly) CDKStack	*fixtureStackWithoutStore;
@property (nonatomic, readonly) CDKStack	*fixtureFullStack;

@end
