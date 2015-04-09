
#import "NSExpressionDescription+CoreDataKit.h"


@implementation NSExpressionDescription (CoreDataKit)

- (instancetype)initWithFunction:(NSString *)function key:(NSString *)key resultType:(NSAttributeType)type {
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:key];
	
	typeof(self) this = [self initWithResultType:type];
	this.expression = [NSExpression expressionForFunction:function arguments:@[keyExpression]];
	this.name = key;
	return this;
}

- (instancetype)initWithResultType:(NSAttributeType)type {
	typeof(self) this = [self init];
	this.expressionResultType = type;
	
	if (type == NSObjectIDAttributeType) {
		this.expression = [NSExpression expressionForEvaluatedObject];
		this.name = @"objectID";
	}
	
	return this;
}

@end
