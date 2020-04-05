#import "FBPRootListController.h"

@implementation FBPRootListController
- (instancetype)init {
    [FBPPackageInfo retrieveControl];
    return [super init];
}
- (NSArray *)specifiers {
    if (!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    return _specifiers;
}
- (id)readPreferenceValue:(PSSpecifier*)specifier {
    NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	return (plist[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	plist[specifier.properties[@"key"]] = value;
	[plist writeToFile:path atomically:true];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName)
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, true);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Kill Facebook" style:UIBarButtonItemStylePlain target:self action:@selector(killall)];
    self.navigationItem.rightBarButtonItem = button;
}
- (void)killall {
    NSTask *killall = [[NSTask alloc] init];
    [killall setLaunchPath:@"/usr/bin/killall"];
    [killall setArguments:@[@"-9", @"Facebook"]];
    [killall launch];
}
@end
