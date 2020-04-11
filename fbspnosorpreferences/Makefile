include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = FBSpNOsorPreferences

FBSpNOsorPreferences_FILES = $(wildcard *.m)
FBSpNOsorPreferences_INSTALL_PATH = /Library/PreferenceBundles
FBSpNOsorPreferences_FRAMEWORKS = UIKit
FBSpNOsorPreferences_PRIVATE_FRAMEWORKS = Preferences
FBSpNOsorPreferences_EXTRA_FRAMEWORKS = libJCX
FBSpNOsorPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FBSpNOsorPreferences.plist$(ECHO_END)
