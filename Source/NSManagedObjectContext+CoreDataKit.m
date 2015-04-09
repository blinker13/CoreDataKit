
#import "NSManagedObjectContext+CoreDataKit.h"


@implementation NSManagedObjectContext (CoreDataKit)

- (void)startForwardingChangesToContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	NSString *name = NSManagedObjectContextDidSaveNotification;
	SEL action = @selector(mergeChangesFromContextDidSaveNotification:);
	[center addObserver:context selector:action name:name object:self];
}

- (void)stopForwardingChangesToContext:(NSManagedObjectContext *)context {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	NSString *name = NSManagedObjectContextDidSaveNotification;
	[center removeObserver:context name:name object:self];
}


#pragma mark -

- (NSManagedObject *)managedObjectForObjectURI:(NSURL *)objectURI {
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	NSManagedObjectID *objectID = [coordinator managedObjectIDForURIRepresentation:objectURI];
	return [self existingObjectWithID:objectID error:nil];
}

@end
