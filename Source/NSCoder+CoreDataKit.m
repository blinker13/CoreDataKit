
#import "NSCoder+CoreDataKit.h"
#import "NSManagedObjectContext+CoreDataKit.h"


@implementation NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)object forKey:(NSString *)key {
	[self encodeObject:object forKey:key];
}

- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context {
	NSURL *objectURI = [self decodeObjectForKey:key];
	
	if (objectURI) {
		return [context managedObjectForObjectURI:objectURI];
	}
	return nil;
}

@end
