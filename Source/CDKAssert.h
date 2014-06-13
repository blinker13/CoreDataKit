//
//  CDKAssert.h
//  CoreDataKit
//
//  Created by Felix Gabel on 16/05/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import Foundation;


#define CDKAssertError(e)	NSAssert(!(e), @"%@/n%@", error.localizedDescription, error.userInfo)
