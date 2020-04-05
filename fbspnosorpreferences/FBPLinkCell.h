#import "FBPTableCell.h"

@interface FBPLinkCell : FBPTableCell {
    NSURL *_avatarURL;
    UIView *_avatarView;
    UIImageView *_avatarImageView;
    UIImage *_avatar;
    NSString *_avatarImageSystemName;
    NSString *_accessoryImageSystemName;
    NSURL *_linkURL;
    bool _shouldDisplayAvatar;
}
- (void)loadAvatarIfNeeded;
- (void)setAvatar:(UIImage *)image;
- (void)setAvatarHidden:(bool)hidden;
- (void)setLinkURL:(NSURL *)url;
@end
