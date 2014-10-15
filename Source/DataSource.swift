//
//  DataSource.swift
//  CoreDataKit
//
//  Created by Felix Gabel on 03/10/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

import CoreData


public protocol DataSourceDelegate : class {
	
	typealias Associate
	typealias ManagedObject
	
	func dataSourceWillChangeContent(dataSource:DataSource<Self>)
	func dataSourceDidChangeContent(dataSource:DataSource<Self>)
	
	func dataSource(dataSource:DataSource<Self>, didInsert section:Int)
	func dataSource(dataSource:DataSource<Self>, didDelete section:Int)
	
	func dataSource(dataSource:DataSource<Self>, didInsert object:ManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource<Self>, didDelete object:ManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource<Self>, didUpdate object:ManagedObject, at indexPath:NSIndexPath)
	func dataSource(dataSource:DataSource<Self>, didMove object:ManagedObject, at indexPath:NSIndexPath, to:NSIndexPath)
	
	func dataSource(dataSource:DataSource<Self>, associateFor object:ManagedObject, at indexPath:NSIndexPath) -> Associate
	func dataSource(dataSource:DataSource<Self>, shouldDelete object:ManagedObject, at indexPath:NSIndexPath)
}


//MARK: -

public class DataSource<D:DataSourceDelegate where D.ManagedObject == NSManagedObject> : NSFetchedResultsControllerDelegate {

	public weak var delegate:D?
	
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
	
	public subscript(indexPath:NSIndexPath) -> D.ManagedObject {
		return self.fetchedResults.objectAtIndexPath(indexPath) as D.ManagedObject
	}
	
	public subscript(object:D.ManagedObject) -> NSIndexPath? {
		return self.fetchedResults.indexPathForObject(object)
	}
	
	public func deleteAt(indexPath:NSIndexPath) {
		let object = self[indexPath]
		self.delete(object)
	}
	
	public func delete(object:D.ManagedObject) {
		
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
	
	public func controller(controller:NSFetchedResultsController, didChangeObject object:D.ManagedObject, atIndexPath indexPath:NSIndexPath!, forChangeType type:NSFetchedResultsChangeType, newIndexPath:NSIndexPath!) {
		
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
	
	public func generate() -> IndexingGenerator<[D.ManagedObject]> {
		let objects = self.fetchedResults.fetchedObjects as [D.ManagedObject]
		return objects.generate()
	}
}
