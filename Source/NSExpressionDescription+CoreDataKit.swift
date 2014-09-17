//
//  NSExpressionDescription.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSExpressionDescription {

	public convenience init(function:String, key:String, resultType:NSAttributeType) {
		let keyExpression = NSExpression(forKeyPath:key)
		
		self.init(resultType:resultType)
		
		self.expression = NSExpression(forFunction:function, arguments:[keyExpression])
		self.name = key
	}
	
	public convenience init(resultType:NSAttributeType) {
		self.init()
		
		self.expressionResultType = resultType
		
		if (resultType == .ObjectIDAttributeType) {
			self.expression = NSExpression.expressionForEvaluatedObject()
			self.name = "objectID"
		}
	}
}
