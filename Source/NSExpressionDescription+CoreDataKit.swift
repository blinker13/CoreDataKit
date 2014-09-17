//
//  NSExpressionDescription.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSExpressionDescription {

	public class func descriptionWithFunction(function:String, key:String, resultType:NSAttributeType) -> NSExpressionDescription {
		
		let keyExpression = NSExpression(forKeyPath:key)
		let expression = NSExpression(forFunction:function, arguments:[keyExpression])
		
		let description = NSExpressionDescription()
		description.expressionResultType = resultType
		description.expression = expression
		description.name = key
		
		return description
	}
	
	public class func objectIDDescription() -> NSExpressionDescription {
		
		let description = NSExpressionDescription()
		description.expressionResultType = .ObjectIDAttributeType
		description.expression = NSExpression.expressionForEvaluatedObject()
		description.name = "objectID"
		
		return description
	}
}
