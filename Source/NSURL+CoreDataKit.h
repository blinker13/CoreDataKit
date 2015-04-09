
@import Foundation;


@interface NSURL (CoreDataKit)

+ (instancetype)defaultStoreURL;
+ (instancetype)storeURLWithName:(NSString *)name;

- (instancetype)storeURLByAppendingName:(NSString *)name;

@end
