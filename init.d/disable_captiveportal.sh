#!/system/bin/sh

# AOSP 11 Captive Portal is a network connectivity check procedure
# executed when you connect to a WLAN network which has
# a user sign-in web form. It uses HTTP status code 204.
#
# AOSP 11 default Captive Portal URLs are as follows:
#
#   http://www.google.com/gen_204
#   http://play.googleapis.com/generate_204
#   https://www.google.com/generate_204
#   http://www.googleapis.cn/generate_204
#   https://connectivitycheck.gstatic.com/generate_204
#   https://ipv6.google.com/generate_204
#
# Defined in AOSP 11 source code paths
#   cts/apps/CtsVerifier/src/com/android/cts/verifier/net/ConnectivityBackgroundTestActivity.java
#   external/autotest/client/common_lib/cros/dbus_send_unittest.py
#   packages/modules/NetworkStack/res/values/config.xml
#   packages/modules/NetworkStack/res/values-mcc460/config.xml
#   packages/modules/NetworkStack/src/android/net/util/NetworkStackUtils.java
#   packages/modules/NetworkStack/tests/unit/src/com/android/server/connectivity/NetworkMonitorTest.java
#   packages/apps/TV/src/com/android/tv/util/NetworkUtils.java
#   system/extras/multinetwork/quick_test.sh
#

# Global options
#
# 0: Completely disable captive portal checks
# 1: Enable captive portal checks (default)
#
settings put global captive_portal_detection_enabled 0

# 0: Don't attempt to detect captive portals
# 1: Prompt user to sign in
# 2: Immediately disconnect from network and do not reconnect to that network in the future
#
settings put global captive_portal_mode 0
