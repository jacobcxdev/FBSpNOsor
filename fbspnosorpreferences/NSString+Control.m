#import "NSString+Control.h"

@implementation NSString (Control)
- (NSString *)stringByInterpolatingPackageInfoFromControl:(NSDictionary *)control {
    NSString *string = [self copy];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{(?<fieldName>\\S+)\\}" options:0 error:&error];
    if (error) return self;
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (int i = matches.count - 1; i >= 0; i--) {
        NSTextCheckingResult *match = matches[i];
        NSString *fieldName = control[[string substringWithRange:[match rangeWithName:@"fieldName"]]];
        if (fieldName) string = [string stringByReplacingOccurrencesOfString:[string substringWithRange:match.range] withString:fieldName];
    }
    return string;
}
@end
