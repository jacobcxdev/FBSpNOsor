#import <UIKit/UIKit.h>

@interface UIColor (HexString)
+ (instancetype)hexString:(NSString *)hexString;
+ (NSArray<UIColor *> *)arrayWithHexString:(NSString *)hexString;
+ (NSArray<id> *)CGColorArrayWithHexString:(NSString *)hexString;
@end
