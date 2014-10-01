//
//  NSPredicate.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 27/09/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSPredicate {

	public class func require(info:[String:AnyObject?]) -> NSPredicate {
		var predicates = [NSPredicate]()
		
		for (key, value) in info {
			predicates.append(key == value)
		}
		
		return NSCompoundPredicate(type:.AndPredicateType, subpredicates:predicates)
	}
}

public extension NSComparisonPredicate {

	public convenience init(_ info:PredicateInfo, modifier:NSComparisonPredicateModifier = NSComparisonPredicateModifier.DirectPredicateModifier, options:NSComparisonPredicateOptions = NSComparisonPredicateOptions(0)) {
		self.init(leftExpression:info.left, rightExpression:info.right, modifier:modifier, type:info.type, options:options)
	}
}
