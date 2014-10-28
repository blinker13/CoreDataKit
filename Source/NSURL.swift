//
//  NSURL.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import Foundation


extension NSURL {

	public class func defaultStoreURL() -> NSURL {
		let bundle = NSBundle.mainBundle()
		let name = bundle.infoDictionary?[kCFBundleExecutableKey] as NSString
		return self.storeURLWithName(name)
	}
	
	public class func storeURLWithName(name:String) -> NSURL {
		let fileManager = NSFileManager.defaultManager()
		let mainBundle = NSBundle.mainBundle()
		
		let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains:.UserDomainMask)
		let url = urls[0].URLByAppendingPathComponent(mainBundle.bundleIdentifier!, isDirectory:true) as NSURL
		return url.storeURLByAppendingName(name)
	}
	
	public func storeURLByAppendingName(name:String) -> NSURL {
		let url = self.URLByAppendingPathComponent(name, isDirectory:false)
		return url.URLByAppendingPathExtension("sqlite")
	}
}
