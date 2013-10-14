//
//  CDKUtility.h
//  CoreDataKit
//
//  Created by Felix Gabel on 6/27/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

@import CoreData;


static inline NSURL * CDKDocumentsDirectory() {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	return [urls lastObject];
}
