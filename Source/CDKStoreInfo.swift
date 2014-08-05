//
//  StoreComponents.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public class CDKStoreInfo {

	public var configuration:String?
	public var options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
	public var type = NSSQLiteStoreType
	public var URL:NSURL
	
	//MARK: -
	
	public init(URL:NSURL) {
		self.URL = URL
	}
	
	public convenience init() {
		let bundle = NSBundle.mainBundle()
		let infos = bundle.infoDictionary
		let name = bundle.infoDictionary[kCFBundleExecutableKey] as NSString
		let url = NSURL.URLWithStoreName(name)
		self.init(URL:url)
	}
	
	//MARK: -
	
	public func directoryURL() -> NSURL {
		return self.URL.URLByDeletingLastPathComponent
	}
}
