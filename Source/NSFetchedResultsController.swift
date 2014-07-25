//
//  NSFetchedResultsController.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 24/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public extension NSFetchedResultsController {

	public func numberOfSections() -> Int {
		return self.sections.count
	}
	
	public func numberOfObjectsInSection(section:Int) -> Int {
		let info = self.sections[section] as NSFetchedResultsSectionInfo
		return info.numberOfObjects
	}
	
	public func objectsAtIndexPaths(indexPaths:[NSIndexPath]) -> [NSManagedObject] {
		var objects = [NSManagedObject]()
		
		for indexPath in indexPaths {
			let object = self.objectAtIndexPath(indexPath) as NSManagedObject
			objects.append(object)
		}
		return objects
	}
	
	public func performWithoutUpdates(handler:() -> ()) {
		let delegate = self.delegate
		self.delegate = nil
		
		handler()
		
		self.delegate = delegate
	}
	
	public func moveObjectAtIndex(index:Int, toIndex:Int, update:(object:NSManagedObject, index:Int) -> Void) {
		let objects = NSMutableOrderedSet(array:self.fetchedObjects)
		let indexes = NSIndexSet(index:index)
		
		objects.moveObjectsAtIndexes(indexes, toIndex:toIndex)
		
		self.performWithoutUpdates {
			let currentIndex = min(index, toIndex)
			let endIndex = max(index, toIndex)
			
			for newIndex in currentIndex...endIndex {
				let object = objects[newIndex] as NSManagedObject
				update(object:object, index:newIndex)
			}
		}
	}
	
	public func deleteObjectAtIndexPath(indexPath:NSIndexPath) {
		let object = self.objectAtIndexPath(indexPath) as NSManagedObject
		self.managedObjectContext.deleteObject(object)
	}
}
