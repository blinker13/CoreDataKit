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
		let stack = self.fixtureStack
		let object = Bar.insert(stack.mainContext) as Bar
		object.name = "Bar"
		
		
	}
}
