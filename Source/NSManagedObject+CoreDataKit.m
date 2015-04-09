
#import "NSManagedObject+CoreDataKit.h"


@implementation NSManagedObject (CoreDataKit)

+ (NSString *)entityName {
	NSString *name = NSStringFromClass(self);
	NSArray *nameParts = [name componentsSeparatedByString:@"."];
	return [nameParts lastObject];
}

+ (instancetype)insertInContext:(NSManagedObjectContext *)context {
	return [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:context];
}


#pragma mark - fetch request

+ (NSFetchRequest *)requestWithSortKey:(NSString *)key ascending:(BOOL)ascending {
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
	NSFetchRequest *request = [self request];
	[request setSortDescriptors:@[sort]];
	return request;
}

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate {
	NSFetchRequest *request = [self request];
	[request setPredicate:predicate];
	return request;
}

+ (NSFetchRequest *)request {
	NSString *entityName = [self entityName];
	return [[NSFetchRequest alloc] initWithEntityName:entityName];
}


#pragma mark -

- (NSURL *)objectURI {
	return [self.objectID URIRepresentation];
}

@end
