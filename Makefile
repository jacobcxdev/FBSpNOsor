FINALPACKAGE = 1

ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Facebook

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FBSpNOser

FBSpNOser_FILES = Tweak.x
FBSpNOser_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
