#import "FBPMailCell.h"

@implementation FBPMailCell
+ (NSURL *)mailtoURLWithEmailAddress:(NSString *)emailAddress {
	emailAddress = [emailAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	return [NSURL URLWithString:[@"mailto:" stringByAppendingString:emailAddress]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
	if (!specifier.properties[@"avatarImageSystemName"]) specifier.properties[@"avatarImageSystemName"] = @"envelope.circle.fill";
	if (!specifier.properties[@"accessoryImageSystemName"]) specifier.properties[@"accessoryImageSystemName"] = @"paperplane.fill";
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier specifier:specifier];
	if (self) {
		_emailAddress = specifier.properties[@"emailAddress"];
		if (!_emailAddress) return self;
		self.detailTextLabel.text = _emailAddress;
		_avatarURL = [NSURL URLWithString:@"https://is1-ssl.mzstatic.com/image/thumb/Purple123/v4/c7/40/e5/c740e5f0-2a62-4fa7-dc1b-66ea3d519545/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/87x0w.png"];
        _linkURL = [self.class mailtoURLWithEmailAddress:_emailAddress];
		[self setCellEnabled:true];
		[self loadAvatarIfNeeded];
    }
	return self;
}
@end
