//
//  NSCoderExtensionTests.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 28/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import XCTest
import CoreDataKit


class NSCoderExtensionTests: XCTestCase {

	func testEncoding() {
		let stack = self.fixtureStack
		let object = Bar.insert(context:stack.mainContext)
		let coder = NSKeyedArchiver()
		
		coder.encodeManagedObject(object, key:"test")
		
		let result = coder.decodeObjectForKey("test") as NSURL
		XCTAssertEqual(result, object.URI, "Encoding Failed")
	}
}
