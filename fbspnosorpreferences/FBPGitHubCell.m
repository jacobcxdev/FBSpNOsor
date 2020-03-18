#import "FBPGitHubCell.h"

@implementation FBPGitHubCell
+ (NSURL *)gitHubURLForRemote:(NSString *)remote {
    remote = [remote stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:[@"https://github.com/" stringByAppendingString:remote]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"avatarImageSystemName"]) specifier.properties[@"avatarImageSystemName"] = @"line.horizontal.3.decrease.circle.fill";
    if (!specifier.properties[@"accessoryImageSystemName"]) specifier.properties[@"accessoryImageSystemName"] = @"chevron.left.slash.chevron.right";
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        _remote = specifier.properties[@"remote"];
        if (!_remote) return self;
        self.detailTextLabel.text = _remote;
        _avatarURL = [NSURL URLWithString:@"https://is4-ssl.mzstatic.com/image/thumb/Purple123/v4/1e/fb/c1/1efbc155-8ef2-4f77-214b-1639fc19ec5d/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/87x0w.png"];
        _linkURL = [self.class gitHubURLForRemote:_remote];
        [self setCellEnabled:true];
        [self loadAvatarIfNeeded];
    }
    return self;
}
@end
