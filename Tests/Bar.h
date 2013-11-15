//
//  Bar.h
//  CoreDataKit
//
//  Created by Felix Gabel on 15/11/13.
//  Copyright (c) 2013 NHCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bar : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * name;

@end
