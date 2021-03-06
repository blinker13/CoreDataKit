
@import Foundation;
@import CoreData;


@interface CDKStack : NSObject

@property (nonatomic, readonly) NSManagedObjectModel			*model;
@property (nonatomic, readonly) NSManagedObjectContext			*mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator	*coordinator;


- (instancetype)initWithModel:(NSManagedObjectModel *)model NS_DESIGNATED_INITIALIZER;
- (instancetype)init;

- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options configuration:(NSString *)configuration;
- (NSPersistentStore *)addStoreAtURL:(NSURL *)url withOptions:(NSDictionary *)options;
- (NSPersistentStore *)addStoreAtURL:(NSURL *)url;
- (NSPersistentStore *)addStore;

@end
