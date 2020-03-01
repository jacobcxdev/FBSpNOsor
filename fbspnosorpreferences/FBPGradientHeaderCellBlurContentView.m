#import "FBPGradientHeaderCellBlurContentView.h"

@implementation FBPGradientHeaderCellBlurContentView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self setup];
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) [self setup];
    return self;
}
- (void)layoutSubviews {
    _borderLayer.frame = self.bounds;
    CGFloat offset = MIN(self.bounds.size.width, self.bounds.size.height) / 8;
    _borderLayer.path = [self borderBezierPathWithRect:self.bounds cornerOrigin:CGPointMake(-offset, -offset) cornerDiameter:offset].CGPath;
}
- (void)setup {
    _borderLayer = [CAShapeLayer layer];
    _borderLayer.fillColor = nil;
    _borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    _borderLayer.lineWidth = 2;
    [self.layer addSublayer:_borderLayer];
}
- (UIBezierPath *)borderBezierPathWithRect:(CGRect)rect cornerOrigin:(CGPoint)cornerOrigin cornerDiameter:(CGFloat)cornerDiameter {
    CGAffineTransform mirrorX = CGAffineTransformMakeScale(1, -1);
    CGAffineTransform mirrorY = CGAffineTransformMakeScale(-1, 1);
    CGAffineTransform translateX = CGAffineTransformMakeTranslation(0, -cornerDiameter);
    CGAffineTransform translateY = CGAffineTransformMakeTranslation(-cornerDiameter, 0);

    UIBezierPath *topLeadingPath = [UIBezierPath bezierPath];
    [topLeadingPath moveToPoint:CGPointMake(cornerOrigin.x + cornerDiameter, cornerOrigin.y + cornerDiameter)];
    [topLeadingPath addArcWithCenter:CGPointMake(cornerOrigin.x + cornerDiameter / 2, cornerOrigin.y + cornerDiameter / 2) radius:cornerDiameter / 2 startAngle:0.5 * M_PI endAngle:0 clockwise:true];
    [topLeadingPath closePath];

    UIBezierPath *topTrailingPath = [topLeadingPath copy];
    [topTrailingPath applyTransform:mirrorY];
    [topTrailingPath applyTransform:translateY];
    [topTrailingPath applyTransform:CGAffineTransformMakeTranslation(fabs(cornerOrigin.x) + rect.size.width, 0)];

    UIBezierPath *bottomLeadingPath = [topLeadingPath copy];
    [bottomLeadingPath applyTransform:mirrorX];
    [bottomLeadingPath applyTransform:translateX];
    [bottomLeadingPath applyTransform:CGAffineTransformMakeTranslation(0, fabs(cornerOrigin.y) + rect.size.height)];

    UIBezierPath *bottomTrailingPath = [bottomLeadingPath copy];
    [bottomTrailingPath applyTransform:mirrorY];
    [bottomTrailingPath applyTransform:translateY];
    [bottomTrailingPath applyTransform:CGAffineTransformMakeTranslation(fabs(cornerOrigin.x) + rect.size.width, 0)];
    
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:rectanglePath];
    [path appendPath:topLeadingPath];
    [path appendPath:topTrailingPath];
    [path appendPath:bottomLeadingPath];
    [path appendPath:bottomTrailingPath];
    return path;
}
@end
