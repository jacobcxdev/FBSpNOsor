export ARCHS = arm64 arm64e
export TARGET = iphone::11.0:latest
INSTALL_TARGET_PROCESSES = Facebook Preferences

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FBSpNOsor

FBSpNOsor_FILES = Tweak.x
FBSpNOsor_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += fbspnosorpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
