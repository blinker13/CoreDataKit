//
//  DataSource.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 03/10/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public protocol DataSourceDelegate : NSObjectProtocol {
	
	func dataSourceWillChangeContent(dataSource:DataSource)
	func dataSourceDidChangeContent(dataSource:DataSource)
	
	func dataSource(dataSource:DataSource, didInsert section:Int)
	func dataSource(dataSource:DataSource, didDelete section:Int)
	
	func dataSource(dataSource:DataSource, didInsert object:NSManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource, didDelete object:NSManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource, didUpdate object:NSManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource, didMove object:NSManagedObject, at indexPath:NSIndexPath, to:NSIndexPath)
	
	func dataSource(dataSource:DataSource, associateFor object:NSManagedObject, at indexPath:NSIndexPath) -> AnyObject
	func dataSource(dataSource:DataSource, shouldDelete object:NSManagedObject, at indexPath:NSIndexPath)
}


//MARK: -

public class DataSource : NSFetchedResultsControllerDelegate {

	public weak var delegate:DataSourceDelegate?
	
	public let context:NSManagedObjectContext
	public let request:NSFetchRequest
	public let sectionKey:String?
	public let cacheName:String?
	
	public var count:Int { return self.fetchedResults.fetchedObjects!.count }
	
	
	//MARK: - Lifecycle
	
	public init(_ request:NSFetchRequest, context:NSManagedObjectContext = Stack.shared.mainContext, shouldSectionResults:Bool = false, cacheName:String? = nil) {
		
		if shouldSectionResults {
			let descriptor = request.sortDescriptors.first as NSSortDescriptor
			self.sectionKey = descriptor.key
		}
		
		self.cacheName = cacheName
		self.context = context
		self.request = request
	}
	
	
	//MARK: -
	
	public subscript(indexPath:NSIndexPath) -> NSManagedObject {
		return self.fetchedResults.objectAtIndexPath(indexPath) as NSManagedObject
	}
	
	public subscript(object:NSManagedObject) -> NSIndexPath? {
		return self.fetchedResults.indexPathForObject(object)
	}
	
	public func deleteAt(indexPath:NSIndexPath) {
		let object = self[indexPath]
		self.delete(object)
	}
	
	public func delete(object:NSManagedObject) {
		
		self.context.performBlockAndWait {
			var error:NSError?
			
			self.context.deleteObject(object)
			
			if !self.context.save(&error) {
//				self.delegate?.dataSource(self, didReceive:error!)
			}
		}
	}
	
	
	//MARK: - NSFetchedResultsControllerDelegate
	
	public func controllerWillChangeContent(controller:NSFetchedResultsController) {
		self.delegate?.dataSourceWillChangeContent(self)
	}
	
	public func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
	
		switch type {
			case .Insert: self.delegate?.dataSource(self, didInsert:sectionIndex)
			case .Delete: self.delegate?.dataSource(self, didDelete:sectionIndex)
			default:break
		}
	}
	
	public func controller(controller:NSFetchedResultsController, didChangeObject object:NSManagedObject, atIndexPath indexPath:NSIndexPath!, forChangeType type:NSFetchedResultsChangeType, newIndexPath:NSIndexPath!) {
		
		switch type {
			case .Insert: self.delegate?.dataSource(self, didInsert:object, at:newIndexPath)
			case .Delete: self.delegate?.dataSource(self, didDelete:object, at:indexPath)
			case .Update: self.delegate?.dataSource(self, didUpdate:object, at:indexPath)
			case .Move: self.delegate?.dataSource(self, didMove:object, at:indexPath, to:newIndexPath)
		}
	}
	
	public func controllerDidChangeContent(controller:NSFetchedResultsController) {
		self.delegate?.dataSourceDidChangeContent(self)
	}
	
	
	//MARK: - Private Implementation
	
	private lazy var fetchedResults:NSFetchedResultsController = {
		var error:NSError?
		
		let fetchedResults = NSFetchedResultsController(fetchRequest:self.request, managedObjectContext:self.context, sectionNameKeyPath:self.sectionKey, cacheName:self.cacheName)
		fetchedResults.delegate = self
		
		if !self.fetchedResults.performFetch(&error) {
//			self.delegate?.dataSource(self, didReceive:error!)
		}
		
		return fetchedResults
	}()
}


//MARK: -

extension DataSource : SequenceType {
	
	public func generate() -> IndexingGenerator<[NSManagedObject]> {
		let objects = self.fetchedResults.fetchedObjects as [NSManagedObject]
		return objects.generate()
	}
}
