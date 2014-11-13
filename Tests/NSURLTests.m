//
//  NSURLTests.m
//  CoreDataKit
//
//  Created by Felix Gabel on 13/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

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
