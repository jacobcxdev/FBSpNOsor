#include "FBPRootListController.h"

@implementation FBPRootListController
- (instancetype)init {
	[FBPPackageInfo retrieveControl];
	return [super init];
}
- (NSArray *)specifiers {
	if (!_specifiers) _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	return _specifiers;
}
- (void)viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Kill Facebook" style:UIBarButtonItemStylePlain target:self action:@selector(killallFacebook)];
	self.navigationItem.rightBarButtonItem = button;
}
- (void)killallFacebook {
	NSTask *killall = [[NSTask alloc] init];
	[killall setLaunchPath:@"/usr/bin/killall"];
	[killall setArguments:@[@"-9", @"Facebook"]];
	[killall launch];
}
@end
