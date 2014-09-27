//
//  NSPredicate.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 27/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSPredicate {

	public class func require(info:[String:AnyObject]) -> NSPredicate {
		var predicates = [NSPredicate]()
		
		for (key, value) in info {
			predicates.append(key == value)
		}
		
		return NSCompoundPredicate(type:.AndPredicateType, subpredicates:predicates)
	}
	
	
	//MARK: -
	
	public class func any(info:(left:NSExpression, right:NSExpression, type:NSPredicateOperatorType)) -> NSPredicate {
		let modifier = NSComparisonPredicateModifier.AnyPredicateModifier
		let options = NSComparisonPredicateOptions(0)
		
		return NSComparisonPredicate(leftExpression:info.left, rightExpression:info.right, modifier:modifier, type:info.type, options:options)
	}
	
	public class func all(info:(left:NSExpression, right:NSExpression, type:NSPredicateOperatorType)) -> NSPredicate {
		let modifier = NSComparisonPredicateModifier.AllPredicateModifier
		let options = NSComparisonPredicateOptions(0)
		
		return NSComparisonPredicate(leftExpression:info.left, rightExpression:info.right, modifier:modifier, type:info.type, options:options)
	}
}

public extension NSComparisonPredicate {

	public convenience init(_ info:(left:NSExpression, right:NSExpression, type:NSPredicateOperatorType), _ modifier:NSComparisonPredicateModifier = NSComparisonPredicateModifier.DirectPredicateModifier, _ options:NSComparisonPredicateOptions = NSComparisonPredicateOptions(0)) {
		self.init(leftExpression:info.left, rightExpression:info.right, modifier:modifier, type:info.type, options:options)
	}
}
