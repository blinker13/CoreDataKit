
@import CoreData;


@interface NSManagedObject (CoreDataKit)

@property (nonatomic, readonly) NSURL	*objectURI;


+ (NSString *)entityName;

+ (instancetype)insertInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestWithSortKey:(NSString *)key ascending:(BOOL)ascending;
+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate;
+ (NSFetchRequest *)request;

@end
