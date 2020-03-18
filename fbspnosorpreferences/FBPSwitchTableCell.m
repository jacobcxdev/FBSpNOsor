#import "FBPSwitchTableCell.h"

@implementation FBPSwitchTableCell
- (void)controlChanged:(UIControl *)control {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", _specifier.properties[@"defaults"]]];
    [plist setObject:[self controlValue] forKey:_specifier.properties[@"key"]];
    [plist writeToFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", _specifier.properties[@"defaults"]] atomically:1];
    [super controlChanged:control];
}
@end
