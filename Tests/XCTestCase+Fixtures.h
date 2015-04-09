
@import CoreDataKit;
@import XCTest;


@interface XCTestCase (Fixtures)

@property (nonatomic, readonly) NSManagedObjectModel	*fixtureModel;
@property (nonatomic, readonly) NSManagedObjectModel	*fixtureMergedModel;

@property (nonatomic, readonly) CDKStack	*fixtureStackWithoutStore;
@property (nonatomic, readonly) CDKStack	*fixtureFullStack;

@end
