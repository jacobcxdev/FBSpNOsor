#import <Foundation/Foundation.h>

@interface FBMemModelObject : NSObject
- (id)initWithFBTree:(void *)arg1;
@end

@interface FBMemNewsFeedEdge : FBMemModelObject
- (id)category;
@end;

@interface FBMemFeedStory : FBMemModelObject
- (id)sponsoredData;
@end

@interface FBVideoChannelPlaylistItem : NSObject
- (id)Bi:(id)arg1 :(id)arg2 :(id)arg3 :(id)arg4 :(id)arg5 :(id)arg6 :(id)arg7;
- (bool)isSponsored;
@end

%hook FBMemNewsFeedEdge
- (id)initWithFBTree:(void *)arg1 {
	id orig = %orig;
	id category = [orig category];
	return category ? [category isEqual:@"ORGANIC"] ? orig : nil : orig;
}
%end

%hook FBMemFeedStory
- (id)initWithFBTree:(void *)arg1 {
	id orig = %orig;
	return [orig sponsoredData] == nil ? orig : nil;
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
