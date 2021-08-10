# Install prebuilt SimpleKeyboard app

# Must be an unsigned build!

# Ref: https://github.com/rkkr/simple-keyboard/

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := SimpleKeyboard
#LOCAL_MODULE_TAGS := optional

# or if signed, use PRESIGNED
LOCAL_CERTIFICATE := platform

# Install into /system/priv-app?
#LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_CLASS := APPS
#LOCAL_MODULE_PATH := $(PRODUCT_OUT)/app
LOCAL_PRODUCT_MODULE := true

LOCAL_SRC_FILES := app/build/outputs/apk/release/app-release-unsigned.apk

include $(BUILD_PREBUILT)
