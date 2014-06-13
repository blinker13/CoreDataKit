//
//  Bar.h
//  CoreDataKit
//
//  Created by Felix Gabel on 15/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import CoreData;


@interface Bar : NSManagedObject

@property (nonatomic, strong) NSDate	*creationDate;
@property (nonatomic, strong) NSString	*name;

@end
