#import "FBPTwitterCell.h"

@implementation FBPTwitterCell
+ (NSURL *)twitterURLForUsername:(NSString *)username {
    username = [username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"aphelion://"]]) {
        return [NSURL URLWithString:[@"aphelion://profile/" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]) {
        return [NSURL URLWithString:[@"tweetbot:///username_profile/" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) {
        return [NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings://"]]) {
        return [NSURL URLWithString:[@"tweetings:///username?screen_name=" stringByAppendingString:username]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        return [NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:username]];
    } else {
        return [NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:username]];
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"avatarImageSystemName"]) specifier.properties[@"avatarImageSystemName"] = @"person.crop.circle.fill";
    if (!specifier.properties[@"accessoryImageSystemName"]) specifier.properties[@"accessoryImageSystemName"] = @"person.crop.circle.badge.plus";
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        _username = specifier.properties[@"username"];
        if (!_username) return self;
        self.detailTextLabel.text = [@"@" stringByAppendingString:_username];
        _avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@/profile_image?size=original", _username]];
        _linkURL = [self.class twitterURLForUsername:_username];
        [self setCellEnabled:true];
        [self loadAvatarIfNeeded];
    }
    return self;
}
@end
