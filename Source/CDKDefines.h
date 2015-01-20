//
//  CDKDefines.h
//  CoreDataKit
//
//  Created by Felix Gabel on 20/01/15.
//  Copyright (c) 2015 Felix Gabel. All rights reserved.
//

@import Foundation;


#define CDKThrowError(e)	NSAssert(!e, @"%@ \n%@", e.localizedDescription, [e localizedDescription]);
