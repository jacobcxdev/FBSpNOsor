FINALPACKAGE = 1

ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Facebook

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FBSpNOsor

FBSpNOsor_FILES = Tweak.x
FBSpNOsor_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
