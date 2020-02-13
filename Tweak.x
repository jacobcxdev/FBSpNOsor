#import <Foundation/Foundation.h>

@interface FBMemNewsFeedEdge : NSObject
+ (id)newFromFBTree:(void *)arg1;
- (id)initWithFBTree:(void *)arg1;
- (id)category;
@end

%hook FBMemNewsFeedEdge
- (id)initWithFBTree:(void *)arg1 {
	id orig = %orig;
	if (![[orig category] isEqual:@"ORGANIC"]) {
		return nil;
	}
	return orig;
}
%end

%ctor {
	NSLog(@"FBSpNOser loaded");
}