#import "FBPPackageInfo.h"

@implementation FBPPackageInfo
static NSMutableDictionary *_control = nil;
+ (NSMutableDictionary *)control {
    if (!_control) [self.class retrieveControl];
    return _control;
}
+ (void)setControl:(NSMutableDictionary *)newValue {
    _control = newValue;
}
+ (void)setControlFromBundleID:(NSString *)bundleID {
    if (!bundleID) return;
    _control = [[NSMutableDictionary alloc] init];
    NSTask *dpkg = [[NSTask alloc] init];
    [dpkg setLaunchPath:@"/usr/bin/dpkg"];
    [dpkg setArguments:@[@"-s", bundleID]];
    NSPipe *dpkgPipe= [NSPipe pipe];
    [dpkg setStandardOutput:dpkgPipe];
    NSFileHandle *outputFile = [dpkgPipe fileHandleForReading];
    [dpkg launch];
    [dpkg waitUntilExit];
    
    NSData *data = [outputFile readDataToEndOfFile];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<fieldName>.+):\\s*(?<fieldContent>.*)" options:0 error:&error];
    NSArray *matches = [regex matchesInString:output options:0 range:NSMakeRange(0, output.length)];
    _control = [[NSMutableDictionary alloc] init];
    for (NSTextCheckingResult *match in matches)
        _control[[output substringWithRange:[match rangeWithName:@"fieldName"]]] = [output substringWithRange:[match rangeWithName:@"fieldContent"]];
}
+ (void)retrieveControl {
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"Info" ofType:@"plist"]];
    [self.class setControlFromBundleID:[info objectForKey:@"FBPPackageBundleID"]];
}
@end
