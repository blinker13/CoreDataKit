//
//  NSPredicateExtensionTests.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 28/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import XCTest
import CoreDataKit


class NSPredicateExtensionTests: XCTestCase {

	func testRequire() {
		let result = NSPredicate.require(["age":13, "name":"Felix"])
		XCTAssertEqual(result.predicateFormat, "age == 13 AND name == \"Felix\"")
	}
	
	func testRequireWithNilValue() {
		let result = NSPredicate.require(["age":13, "name":nil])
		XCTAssertEqual(result.predicateFormat, "age == 13 AND name == nil")
	}
}
