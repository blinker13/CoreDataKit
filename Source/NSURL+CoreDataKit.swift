//
//  NSURL.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


extension NSURL {

	public class func URLWithStoreName(name:String) -> NSURL {
		let fileManager = NSFileManager.defaultManager()
		let mainBundle = NSBundle.mainBundle()
		
		let domain =  NSSearchPathDomainMask.UserDomainMask
		let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains:domain)
		let url = urls[0].URLByAppendingPathComponent(mainBundle.bundleIdentifier, isDirectory:true) as NSURL
		return url.URLByAppendingStoreName(name)
	}
	
	public func URLByAppendingStoreName(name:String) -> NSURL {
		let url = self.URLByAppendingPathComponent(name, isDirectory:false)
		return url.URLByAppendingPathExtension("sqlite")
	}
}
