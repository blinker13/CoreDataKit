//
//  CDKStoreInfo.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 21/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public struct CDKStoreInfo {

	public var options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
	public var type = NSSQLiteStoreType
	public var configuration:String?
	public var URL:NSURL
	
	
	public init(URL:NSURL = NSURL.defaultStoreURL()) {
		self.URL = URL
	}
}


public extension CDKStoreInfo {

	public var directoryURL:NSURL {
		get {return self.URL.URLByDeletingLastPathComponent!}
	}
}
