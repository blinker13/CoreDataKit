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
		let result = NSPredicate.require(["name":"Felix", "age":13])
		XCTAssertEqual(result.predicateFormat, "name == \"Felix\" AND age == 13")
	}
	
	func testRequireWithNilValue() {
		let result = NSPredicate.require(["name":nil, "age":13])
		XCTAssertEqual(result.predicateFormat, "name == nil AND age == 13")
	}
}
