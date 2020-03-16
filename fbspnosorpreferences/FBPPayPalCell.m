#import "FBPPayPalCell.h"

@implementation FBPPayPalCell
+ (NSURL *)paypalURLForUsername:(NSString *)username {
    username = [username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:[@"https://www.paypal.me/" stringByAppendingString:username]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"avatarImageSystemName"]) specifier.properties[@"avatarImageSystemName"] = @"dollarsign.circle.fill";
    if (!specifier.properties[@"accessoryImageSystemName"]) specifier.properties[@"accessoryImageSystemName"] = @"link.circle";
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        _username = specifier.properties[@"username"];
        if (!_username) return self;
        self.detailTextLabel.text = [@"paypal.me/" stringByAppendingString:_username];
        _avatarURL = [NSURL URLWithString:@"https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/79/89/49/79894915-462d-3fb6-7fcd-3c8004639cd1/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/87x0w.png"];
        _linkURL = [self.class paypalURLForUsername:_username];
        [self setCellEnabled:true];
        [self loadAvatarIfNeeded];
    }
    return self;
}
@end
