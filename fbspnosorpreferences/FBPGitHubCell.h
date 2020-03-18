#import "FBPLinkCell.h"

@interface FBPGitHubCell : FBPLinkCell {
    NSString *_remote;
}
+ (NSURL *)gitHubURLForRemote:(NSString *)remote;
@end
