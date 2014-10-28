//
//  Predicate.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 27/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public struct PredicateInfo {
	let left:NSExpression
	let right:NSExpression
	let type:NSPredicateOperatorType
	
	public init(key:String, value:AnyObject, type:NSPredicateOperatorType) {
		self.right = NSExpression(forConstantValue:value)
		self.left = NSExpression(forKeyPath:key)
		self.type = type
	}
}


//MARK: - Less than

public func < (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.LessThanPredicateOperatorType)
}

public func < (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key < value)
}


//MARK: - Less than or equal

public func <= (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.LessThanOrEqualToPredicateOperatorType)
}

public func <= (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key <= value)
}


//MARK: - Greater than

public func > (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.GreaterThanPredicateOperatorType)
}

public func > (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key > value)
}


//MARK: - Greater than or equal

public func >= (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.GreaterThanOrEqualToPredicateOperatorType)
}

public func >= (key:String, value:AnyObject) -> NSPredicate {
	return NSComparisonPredicate(key >= value)
}


//MARK: - Equal

public func == (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.EqualToPredicateOperatorType)
}

public func == (key:String, value:AnyObject?) -> NSPredicate {
	if value != nil { return NSComparisonPredicate(key == value!) }
	else { return NSPredicate(format:"%K == nil", key)! }
}


//MARK: - Not equal

public func != (key:String, value:AnyObject) -> PredicateInfo {
	return PredicateInfo(key:key, value:value, type:.NotEqualToPredicateOperatorType)
}

public func != (key:String, value:AnyObject?) -> NSPredicate {
	if value != nil { return NSComparisonPredicate(key != value!) }
	else { return NSPredicate(format:"%K != nil", key)! }
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

public func ANY(info:PredicateInfo) -> NSPredicate {
	return NSComparisonPredicate(info, modifier:.AnyPredicateModifier)
}

public func ALL(info:PredicateInfo) -> NSPredicate {
	return NSComparisonPredicate(info, modifier:.AllPredicateModifier)
}
