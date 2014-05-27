//
//  CDKDefines.h
//  CoreDataKit
//
//  Created by Felix Gabel on 16/05/14.
//  Copyright (c) 2014 NHCoding. All rights reserved.
//

@import Foundation;


#define CDKDefaultStoreName()	([[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey])

#define CDKAssertError(e)	NSAssert(!(e), @"%@/n%@", error.localizedDescription, error.userInfo)
