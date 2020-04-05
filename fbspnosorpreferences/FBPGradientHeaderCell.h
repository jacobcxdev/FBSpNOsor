#import "FBPGradientHeaderCellBlurContentView.h"

@interface FBPGradientHeaderCell : FBPTableCell {
    UIImage *_icon;
    UIImageView *_iconView;
    UILabel *_label;
    UILabel *_detailLabel;
    UIView *_blurContentView;
    CAGradientLayer *_gradientLayer;
    UIVisualEffectView *_blurView;
    bool _animated;
}
- (void)addAnimation;
@end
