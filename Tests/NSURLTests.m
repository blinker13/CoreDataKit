
@import CoreDataKit;
@import XCTest;


@interface NSURLTests : XCTestCase
@end


@implementation NSURLTests

- (void)testStoreURLByAppendingName {
	NSString *expectedPath = @"foo/bar/test.sqlite";
	NSURL *startURL = [[NSURL alloc] initWithString:@"foo/bar"];
	
	NSURL *result = [startURL storeURLByAppendingName:@"test"];
	
	XCTAssertEqualObjects(result.absoluteString, expectedPath);
}

- (void)testStoreURLByAppendingNameWithEmptyURL {
	NSURL *startURL = [NSURL URLWithString:nil];
	
	NSURL *result = [startURL storeURLByAppendingName:@"test"];
	
	XCTAssertNil(result.absoluteString, "An empty URL should not append the store name");
}

@end
