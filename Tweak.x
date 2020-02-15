#import <Foundation/Foundation.h>

@interface FBMemNewsFeedEdge : NSObject
- (id)initWithFBTree:(void *)arg1;
- (id)category;
@end;

@interface FBVideoChannelPlaylistItem : NSObject
- (id)Bi:(id)arg1 :(id)arg2 :(id)arg3 :(id)arg4 :(id)arg5 :(id)arg6 :(id)arg7;
- (bool)isSponsored;
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

%hook FBVideoChannelPlaylistItem
- (id)Bi:(id)arg1 :(id)arg2 :(id)arg3 :(id)arg4 :(id)arg5 :(id)arg6 :(id)arg7 {
	id orig = %orig;
	return [orig isSponsored] ? nil : orig;
}
%end

%ctor {
	NSLog(@"FBSpNOser loaded");
}
