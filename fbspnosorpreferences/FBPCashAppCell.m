#import "FBPCashAppCell.h"

@implementation FBPCashAppCell
+ (NSURL *)cashAppURLForUsername:(NSString *)cashTag {
    cashTag = [cashTag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:[@"https://cash.app/" stringByAppendingString:cashTag]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    if (!specifier.properties[@"avatarImageSystemName"]) specifier.properties[@"avatarImageSystemName"] = @"dollarsign.circle.fill";
    if (!specifier.properties[@"accessoryImageSystemName"]) specifier.properties[@"accessoryImageSystemName"] = @"link.circle";
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        _cashTag = specifier.properties[@"cashTag"];
        if (!_cashTag) return self;
        self.detailTextLabel.text = [@"cash.app/" stringByAppendingString:_cashTag];
        _avatarURL = [NSURL URLWithString:@"https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/88/54/42/88544217-121a-cc19-8db6-5c0da87095e1/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/87x0w.png"];
        _linkURL = [self.class cashAppURLForUsername:_cashTag];
        [self setCellEnabled:true];
        [self loadAvatarIfNeeded];
    }
    return self;
}
@end
