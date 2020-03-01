#import "FBPLinkCell.h"

@interface FBPTwitterCell : FBPLinkCell {
    NSString *_username;
}
+ (NSURL *)twitterURLForUsername:(NSString *)username;
@end
