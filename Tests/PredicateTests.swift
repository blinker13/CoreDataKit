//
//  PredicateTests.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 27/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import XCTest
import CoreDataKit


class PredicateTests: XCTestCase {

	func testLessThanOperator() {
		let result:NSPredicate = "age" < 21
		
		XCTAssertEqual(result.predicateFormat, "age < 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
	}
	
	func testLessThanOrEqual() {
		let result:NSPredicate = "age" <= 21
		
		XCTAssertEqual(result.predicateFormat, "age <= 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
	}
	
	func testGreaterThanOperator() {
		let result:NSPredicate = "age" > 21
		
		XCTAssertEqual(result.predicateFormat, "age > 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
	}
	
	func testGreaterThanOrEqual() {
		let result:NSPredicate = "age" >= 21
		
		XCTAssertEqual(result.predicateFormat, "age >= 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
	}
	
	func testEqualOperator() {
		let result:NSPredicate = "age" == 21
		
		XCTAssertEqual(result.predicateFormat, "age == 21")
		
		XCTAssertFalse(result.evaluateWithObject(["age":20]))
		XCTAssertTrue(result.evaluateWithObject(["age":21]))
		XCTAssertFalse(result.evaluateWithObject(["age":22]))
		
		let nilResult:NSPredicate = "name" == nil
		XCTAssertEqual(nilResult.predicateFormat, "name == nil")
	}
	
	func testNotEqualOperator() {
		let result:NSPredicate = "age" != 21
		
		XCTAssertEqual(result.predicateFormat, "age != 21")
		
		XCTAssertTrue(result.evaluateWithObject(["age":20]))
		XCTAssertFalse(result.evaluateWithObject(["age":21]))
		XCTAssertTrue(result.evaluateWithObject(["age":22]))
		
		let nilResult:NSPredicate = "name" != nil
		XCTAssertEqual(nilResult.predicateFormat, "name != nil")
	}
	
	
	//MARK: - Compounds
	
	func testAndOperator() {
		let result:NSPredicate = "name" == "Foo" && "age" > 13
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" AND age > 13")
	}
	
	func testInfixAndOperator() {
		var result:NSPredicate = "name" == "Foo"
		result &&= "age" > 13
		
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" AND age > 13")
	}
	
	func testOrOperator() {
		let result:NSPredicate = "name" == "Foo" || "age" > 13
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" OR age > 13")
	}
	
	func testInfixOrOperator() {
		var result:NSPredicate = "name" == "Foo"
		result ||= "age" > 13
		
		XCTAssertEqual(result.predicateFormat, "name == \"Foo\" OR age > 13")
	}
	
	func testNotOperator() {
		let result:NSPredicate = !("name" == "Foo")
		XCTAssertEqual(result.predicateFormat, "NOT name == \"Foo\"")
	}
	
	
	//MARK: - Modifier
	
	func testAnyModifier() {
		let result = ANY("age" == 21)
		XCTAssertEqual(result.predicateFormat, "ANY age == 21")
	}
	
	func testAllModifier() {
		let result = ALL("age" == 21)
		XCTAssertEqual(result.predicateFormat, "ALL age == 21")
	}
}
