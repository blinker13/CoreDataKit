//
//  Predicate.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 27/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


//MARK: - Less than

public func < (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .LessThanPredicateOperatorType)
}

public func < (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key < value)
}


//MARK: - Less than or equal

public func <= (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .LessThanOrEqualToPredicateOperatorType)
}

public func <= (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key <= value)
}


//MARK: - Greater than

public func > (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .GreaterThanPredicateOperatorType)
}

public func > (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key > value)
}


//MARK: - Greater than or equal

public func >= (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .GreaterThanOrEqualToPredicateOperatorType)
}

public func >= (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key >= value)
}


//MARK: - Equal

public func == (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .EqualToPredicateOperatorType)
}

public func == (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key == value)
}


//MARK: - Not equal

public func != (key:String, value:AnyObject) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	return expressionTuple(key, value, .NotEqualToPredicateOperatorType)
}

public func != (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key != value)
}


//MARK: - Compounds

public func && (left:NSPredicate, right:NSPredicate) -> NSPredicate {
	return NSCompoundPredicate(type:.AndPredicateType, subpredicates:[left, right])
}

infix operator &&= {}
public func &&= (inout left:NSPredicate, right:NSPredicate) {
	left = NSCompoundPredicate(type:.AndPredicateType, subpredicates:[left, right])
}

public func || (left:NSPredicate, right:NSPredicate) -> NSPredicate {
	return NSCompoundPredicate(type:.OrPredicateType, subpredicates:[left, right])
}

infix operator ||= {}
public func ||= (inout left:NSPredicate, right:NSPredicate) {
	left = NSCompoundPredicate(type:.OrPredicateType, subpredicates:[left, right])
}

public prefix func ! (predicate:NSPredicate) -> NSPredicate {
	return NSCompoundPredicate(type:.NotPredicateType, subpredicates:[predicate])
}


//MARK: - 

public func ANY(any:(left:NSExpression, right:NSExpression, type:NSPredicateOperatorType)) -> NSPredicate {
	let modifier = NSComparisonPredicateModifier.AnyPredicateModifier
	return NSComparisonPredicate(any, modifier)
}

public func ALL(any:(left:NSExpression, right:NSExpression, type:NSPredicateOperatorType)) -> NSPredicate {
	let modifier = NSComparisonPredicateModifier.AllPredicateModifier
	return NSComparisonPredicate(any, modifier)
}


//MARK: - Private 

private func expressionTuple(key:String, value:AnyObject, type:NSPredicateOperatorType) -> (left:NSExpression, right:NSExpression, type:NSPredicateOperatorType) {
	let right = NSExpression(forConstantValue:value)
	let left = NSExpression(forKeyPath:key)
	return (left, right, type)
}
