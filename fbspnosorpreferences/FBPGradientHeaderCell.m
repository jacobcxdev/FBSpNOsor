#import "FBPGradientHeaderCell.h"

@implementation FBPGradientHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier specifier:specifier];
    if (self) {
        if (!specifier.properties[@"height"]) specifier.properties[@"height"] = [NSNumber numberWithInt:176];
        self.textLabel.text = nil;
        self.detailTextLabel.text = nil;

        UIBlurEffect *blurEffect;
        if (@available(iOS 13, *)) blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial];
        else blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:blurEffect]];
        [self insertSubview:_blurView atIndex:0];

        _blurView.translatesAutoresizingMaskIntoConstraints = false;
        [_blurView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
        [_blurView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
        [_blurView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = true;
        [_blurView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;

        _blurContentView = [[FBPGradientHeaderCellBlurContentView alloc] initWithFrame:self.bounds];
        [_blurView.contentView addSubview:_blurContentView];
        _blurContentView.translatesAutoresizingMaskIntoConstraints = false;
        [_blurContentView.topAnchor constraintEqualToAnchor:_blurView.contentView.topAnchor constant:22].active = true;
        [_blurContentView.bottomAnchor constraintEqualToAnchor:_blurView.contentView.bottomAnchor constant:-22].active = true;
        [_blurContentView.leadingAnchor constraintEqualToAnchor:_blurView.contentView.leadingAnchor constant:22].active = true;
        [_blurContentView.trailingAnchor constraintEqualToAnchor:_blurView.contentView.trailingAnchor constant:-22].active = true;

        self.contentView.translatesAutoresizingMaskIntoConstraints = false;
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:22].active = true;
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-22].active = true;
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:22].active = true;
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-22].active = true;

        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = [UIColor CGColorArrayWithHexString:specifier.properties[@"colors"]];
        _gradientLayer.startPoint = CGPointMake(0, 1);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.frame = self.bounds;
        [_blurView.layer insertSublayer:_gradientLayer atIndex:0];

        _animated = specifier.properties[@"animated"];

        if (specifier.properties[@"icon"]) _icon = [UIImage imageNamed:specifier.properties[@"icon"] inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        if (_icon) {
            _iconView = [[UIImageView alloc] initWithImage:_icon];
            _iconView.contentMode = UIViewContentModeScaleAspectFit;
            [_iconView.widthAnchor constraintEqualToAnchor:_iconView.heightAnchor constant:_iconView.frame.size.width / _iconView.frame.size.height].active = true;
            _iconView.layer.shadowColor = [UIColor blackColor].CGColor;
            _iconView.layer.shadowOpacity = 0.25;
            _iconView.layer.shadowOffset = CGSizeMake(1, 1);
        }

        _label = [[UILabel alloc] init];
        _label.text = specifier.properties[@"label"] ? [specifier.properties[@"label"] stringByInterpolatingPackageInfoFromControl:[FBPPackageInfo control]] : [FBPPackageInfo control][@"Name"];
        _label.font = [UIFont fontWithDescriptor:[[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1].fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold] size:0];
        _label.textColor = [UIColor whiteColor];
        _label.layer.shadowColor = [UIColor blackColor].CGColor;
        _label.layer.shadowOpacity = 0.25;
        _label.layer.shadowOffset = CGSizeMake(1, 1);

        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _detailLabel.text = specifier.properties[@"subtitle"] ? [specifier.properties[@"subtitle"] stringByInterpolatingPackageInfoFromControl:[FBPPackageInfo control]] : [@"v" stringByAppendingString:[FBPPackageInfo control][@"Version"]];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        _detailLabel.layer.shadowOpacity = 0.25;
        _detailLabel.layer.shadowOffset = CGSizeMake(1, 1);

        UIStackView *labelVStack = [[UIStackView alloc] initWithArrangedSubviews:@[_label, _detailLabel]];
        labelVStack.axis = UILayoutConstraintAxisVertical;
        labelVStack.spacing = 10;

        UIView *labelContainerView = [[UIView alloc] init];
        [labelContainerView addSubview:labelVStack];
        labelVStack.translatesAutoresizingMaskIntoConstraints = false;
        [labelVStack.centerXAnchor constraintEqualToAnchor:labelContainerView.centerXAnchor].active = true;
        [labelVStack.centerYAnchor constraintEqualToAnchor:labelContainerView.centerYAnchor].active = true;
        [self.contentView addSubview:labelContainerView];
        labelContainerView.translatesAutoresizingMaskIntoConstraints = false;
        [labelContainerView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
        [labelContainerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = true;
        [labelContainerView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;

        if (_iconView) {
            UIView *iconContainerView = [[UIView alloc] init];
            [iconContainerView addSubview:_iconView];
            _iconView.translatesAutoresizingMaskIntoConstraints = false;
            [_iconView.heightAnchor constraintEqualToAnchor:iconContainerView.heightAnchor multiplier:0.667].active = true;
            [_iconView.centerXAnchor constraintEqualToAnchor:iconContainerView.centerXAnchor].active = true;
            [_iconView.centerYAnchor constraintEqualToAnchor:iconContainerView.centerYAnchor].active = true;
            [self.contentView insertSubview:iconContainerView atIndex:0];
            iconContainerView.translatesAutoresizingMaskIntoConstraints = false;
            [iconContainerView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
            [iconContainerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = true;
            [iconContainerView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
            [iconContainerView.trailingAnchor constraintEqualToAnchor:labelContainerView.leadingAnchor].active = true;
            [iconContainerView.widthAnchor constraintEqualToAnchor:labelContainerView.widthAnchor].active = true;
            _label.textAlignment = NSTextAlignmentRight;
            _detailLabel.textAlignment = NSTextAlignmentRight;
        } else {
            [labelContainerView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
            _label.textAlignment = NSTextAlignmentCenter;
            _detailLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return self;
}
- (void)didMoveToWindow {
    if (_animated) [self addAnimation];
}
- (void)layoutSubviews {
    _gradientLayer.frame = self.bounds;
}
- (void)addAnimation {
    [_gradientLayer removeAllAnimations];
    const CFTimeInterval duration = [(NSNumber *)_specifier.properties[@"animationDuration"] doubleValue] ?: 15;
    const CAKeyframeAnimation *startPointAnimation = [CAKeyframeAnimation animationWithKeyPath:@"startPoint"];
    startPointAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(-1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(-1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(-1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(0, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(0, 1)]];
    startPointAnimation.duration = duration;
    const CAKeyframeAnimation *endPointAnimation = [CAKeyframeAnimation animationWithKeyPath:@"endPoint"];
    endPointAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(1, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(-1, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(-1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, -1)],
                    [NSValue valueWithCGPoint:CGPointMake(1, 0)]];
    endPointAnimation.duration = duration;
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[startPointAnimation, endPointAnimation];
    animationGroup.duration = duration;
    animationGroup.repeatCount = INFINITY;
    
    [_gradientLayer addAnimation:animationGroup forKey:@"FBPAnimation"];
}
@end
