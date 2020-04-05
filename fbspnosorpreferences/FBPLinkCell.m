#import "FBPLinkCell.h"

@implementation FBPLinkCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        CGFloat size = 38;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.detailTextLabel.text = specifier.properties[@"subtitle"] ?: @"";
        _avatarImageSystemName = specifier.properties[@"avatarImageSystemName"];
        _accessoryImageSystemName = specifier.properties[@"accessoryImageSystemName"];
        _shouldDisplayAvatar = specifier.properties[@"shouldDisplayAvatar"] && [specifier.properties[@"shouldDisplayAvatar"] boolValue];
        _avatarURL = [NSURL URLWithString:specifier.properties[@"avatarURL"]];
        _linkURL = [NSURL URLWithString:specifier.properties[@"linkURL"]];

        self.accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
        if (_accessoryImageSystemName)
            if (@available(iOS 13, *)) ((UIImageView *)self.accessoryView).image = [UIImage systemImageNamed:_accessoryImageSystemName];
        [self.accessoryView sizeToFit];

        if (_shouldDisplayAvatar) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), false, [UIScreen mainScreen].scale);
            specifier.properties[@"iconImage"] = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            _avatarView = [[UIView alloc] initWithFrame:self.imageView.bounds];
            _avatarView.contentMode = UIViewContentModeScaleAspectFit;
            _avatarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _avatarView.userInteractionEnabled = false;
            _avatarView.clipsToBounds = true;
            _avatarView.layer.cornerRadius = size / 2;
            _avatarView.layer.borderWidth = 2;
            if (@available(iOS 13, *)) _avatarView.layer.borderColor = [UIColor tertiaryLabelColor].CGColor;
            else _avatarView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
            [self.imageView addSubview:_avatarView];

            _avatarImageView = [[UIImageView alloc] initWithFrame:_avatarView.bounds];
            _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
            _avatarImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _avatarImageView.userInteractionEnabled = false;
            _avatarImageView.layer.minificationFilter = kCAFilterTrilinear;
            if (_avatarImageSystemName)
                if (@available(iOS 13, *)) _avatarImageView.image = [UIImage systemImageNamed:_avatarImageSystemName];
            _avatarImageView.tintColor = [UIColor lightGrayColor];
            [_avatarView addSubview:_avatarImageView];
            
            [self loadAvatarIfNeeded];
        }
    }
    return self;
}
- (void)loadAvatarIfNeeded {
    if (_avatar) return;
    if (!_avatarURL) return;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:_avatarURL];
        if (!data) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setAvatar:[UIImage imageWithData:data]];
            [self setAvatarHidden:false];
        });
    });
}
- (void)setAvatar:(UIImage *)image {
    bool hidden = _avatarView.alpha == 0;
    if (!hidden) [self setAvatarHidden:true];
    _avatarImageView.image = image;
    if (!hidden) [self setAvatarHidden:false];
}
- (void)setAvatarHidden:(bool)hidden {
    if (hidden == _avatarView.alpha == 0) return;
    [UIView animateWithDuration:0.25 animations: ^{
        _avatarView.alpha = hidden ? 0 : 1;
    }];
}
- (void)setLinkURL:(NSURL *)url {
    _linkURL = url;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!selected || !_linkURL) return;
    if ([[UIApplication sharedApplication] canOpenURL:_linkURL])
        [[UIApplication sharedApplication] openURL:_linkURL options:@{} completionHandler:nil];
}
@end
