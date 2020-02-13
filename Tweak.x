#import <Foundation/Foundation.h>

@interface FBMemSponsoredData : NSObject
- (id)initWithFBTree:(void *)arg1;
@end

%hook FBMemSponsoredData
- (id)initWithFBTree:(void *)arg1 {
	return nil;
}
%end

%ctor {
	NSLog(@"FBSpNOser loaded");
}