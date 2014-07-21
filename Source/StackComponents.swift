//
//  StackComponents.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


class StackComponents {

	var configuration:String?
	var options:[String:AnyObject]
	var type:String
	var URL:NSURL
	
	
	init(URL:NSURL) {
		self.options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
		self.type = NSSQLiteStoreType
		self.URL = URL
	}
	
	convenience init() {
		let bundle = NSBundle.mainBundle()
		let infos = bundle.infoDictionary
		let name = bundle.infoDictionary[kCFBundleExecutableKey] as NSString
		let url = NSURL.URLWithStoreName(name)
		self.init(URL:url)
	}
}
