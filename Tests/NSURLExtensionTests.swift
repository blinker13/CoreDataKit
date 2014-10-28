//
//  NSURLExtensionTests.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 17/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreDataKit
import XCTest


class NSURLExtensionTests: XCTestCase {

	func testStoreURLByAppendingName() {
		let expectedPath = "foo/bar/test.sqlite"
		let startURL = NSURL(string:"foo/bar")!
		
		let testURL = startURL.storeURLByAppendingName("test")
		
		XCTAssertEqual(testURL.absoluteString!, expectedPath)
	}
	
	func testStoreURLByAppendingNameWithEmptyURL() {
		let testURL = NSURL().storeURLByAppendingName("test")
		XCTAssertNil(testURL.absoluteString, "An empty URL should not append the store name")
	}
}
