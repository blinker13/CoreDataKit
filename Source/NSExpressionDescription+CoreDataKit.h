
@import CoreData;


@interface NSExpressionDescription (CoreDataKit)

- (instancetype)initWithFunction:(NSString *)function key:(NSString *)key resultType:(NSAttributeType)type;
- (instancetype)initWithResultType:(NSAttributeType)type;

@end
