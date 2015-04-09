
@import CoreData;


@interface NSManagedObjectContext (CoreDataKit)

- (void)startForwardingChangesToContext:(NSManagedObjectContext *)context;
- (void)stopForwardingChangesToContext:(NSManagedObjectContext *)context;

- (NSManagedObject *)managedObjectForObjectURI:(NSURL *)objectURI;

@end
