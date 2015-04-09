
@import Foundation;
@import CoreData;


@interface NSCoder (CoreDataKit)

- (void)encodeManagedObject:(NSManagedObject *)object forKey:(NSString *)key;
- (id)decodeManagedObjectForKey:(NSString *)key inContext:(NSManagedObjectContext *)context;

@end
