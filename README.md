# LineageOS 18.1 patches & tweaks for Samsung S5 Neo (s5neolte)

This repository has the following patches such as:

- Enable NFC service

- Bypass safe volume warning dialog

- Enable call recording

  - Bypasses all country restrictions

- Replace Google DNS server references

Original source code repositories:

- [GitHub - LineageOS/android_device_samsung_s5neolte](https://github.com/LineageOS/android_device_samsung_s5neolte)

- [GitHub - LineageOS/android_device_samsung_universal7580-common](https://github.com/LineageOS/android_device_samsung_universal7580-common)

- [GitHub - LineageOS/android_hardware_samsung_nfc](https://github.com/LineageOS/android_hardware_samsung_nfc)

- [GitHub - LineageOS/android](https://github.com/LineageOS/android)

## Usage

Follow [Lineage OS for Samsung S5 Neo guide](https://wiki.lineageos.org/devices/s5neolte/build) **until** `brunch s5neolte` command. Before issuing that command, you need to put files of this repository in place.

## Some notes about the official LineageOS build guide

  - **DO NOT** install `recovery.img`. LineageOS Recovery is horrible, TWRP is great. Use TWRP. Thanks. If you mistakenly install `recovery.img` anyway, getting rid of it requires use of heimdall to flash back TWRP `recovery.img` (`heimdall flash --RECOVERY <twrp-recovery>.img`)

  - Install only contents of LineageOS zip file `lineage-18.1-YYYYMMDD-UNOFFICIAL-s5neolte.zip` using TWRP

  - You may already have `repo` command pre-installed on your system

  - Use command `repo init -u https://github.com/LineageOS/android.git -b lineage-18.1`

  - `./extract-files.sh` commands relative to LineageOS source dir:

    - `device/samsung/universal7580-common/extract-files.sh`

    - `device/samsung/s5neolte/extract-files.sh`

    - Both must be executed

  - In order to `./extract-files.sh` commands fully succeed, you must have Samsung Android `6.0.1` preinstalled on your phone. Otherwise you get errors for missing files.

## LineageOS requirements for s5neolte

- If you have original Samsung Android OS installed, it must be version `6.0.1`. LineageOS installation on phones using older Android versions (`5.1.1`, etc.) simply fails.

  - If you do not have Android `6.0.1` , get official Samsung update with [samloader](https://github.com/nlscc/samloader). Extract `zip` and `tar.md5` files, until you get all required `.img` and `.bin` files. Flash extracted `.bin` and `.img` files with [heimdall](https://github.com/Benjamin-Dobell/Heimdall)

    - Samloader [Arch Linux PKGBUILD (AUR)](https://aur.archlinux.org/packages/samloader-git/)

    - Take backup with TWRP before issuing `heimdall` commands

    - Relevant files are as follows: `boot.img`, `system.img`, `userdata.img`, `cm.bin`, `param.bin`, `sboot.bin`, `modem.bin`, `cache.img`, `hidden.img`

      - If you use custom recovery such as TWRP, **do not** flash `recovery.img`

      - File `S5NEOLTE_<XXX>_OPEN.pit` is a partition definition file. You may extract one directly from your phone using `heimdall`, as well.

    - You must patch heimdall to successfully flash your Samsung S5 Neo phone. Compile heimdall, and apply patch file [misc/heimdall/patch_filepartindex.patch](misc/heimdall/patch_filepartindex.patch). See [this GitHub issue](https://github.com/Benjamin-Dobell/Heimdall/issues/347) for details.

    - Heimdall source code: [GitHub - alexax66/Heimdall](https://github.com/alexax66/Heimdall)

    - Heimdall [Arch Linux PKGBUILD](https://github.com/archlinux/svntogit-community/tree/packages/heimdall/trunk)

    - Heimdall usage and command explanations: [SAMMobile - [Firmware]Restoring Stock Firmware with Heimdall](https://www.sammobile.com/forum/threads/45894-Restoring-Stock-Firmware-with-Heimdall)

    - Heimdall flash command for Samsung S5 Neo: `heimdall flash --BOOT boot.img --SYSTEM system.img --USERDATA userdata.img --CM cm.bin --PARAM param.bin --BOOTLOADER sboot.bin --RADIO modem.bin --CACHE cache.img --HIDDEN hidden.img`

      - **WARNING**: Use absolutely correct, Samsung provided files in `heimdall` command. Otherwise the flash process may fail and you end up with a bricked phone.

      - Flashing `USERDATA` is not necessary

## Additional tips

- You may build parts of LineageOS using `mm` and `mmm` commands after sourcing `build/envsetup.sh`

  - This is useful for partial patches

  - For instance, building only `Dialer` APK, run `mmm packages/apps/Dialer` in lineage source root dir

- If in any case, you get error message `cmd: unknown variable '$(PATH_OVERRIDE_SOONG)'`, run `breakfast <lunch-command-option>` command at Lineage OS source directory root again before issuing any other commands. Running `breakfast` command can take 10-15 minutes without any visible progress displayed

- Before starting Lineage OS, you may need to wipe cache & Dalvik cache in TWRP (`Wipe -> Advanced Wipe -> [Dalvik / ART Cache, Cache]`)

### Init.d support

No, do not use `/system/etc/init.d/` or look for such folders. Simply put your boot time scripts into `/data/adb/service.d/` folder, set their owner to `root:root` and permission bits to `0700`. You may give less restrictive permissions at your own risk. Default owner of these scripts seems to be `root:shell`. You may use TWRP to set owner & permission information.

Optionally, folder `/data/adb/post-fs-data.d/` may be used, as well.

#### Additional startup scripts

Disable Captive Portal on startup.

See: [disable_captiveportal.sh](init.d/disable_captiveportal.sh)

### DNS modifications

Replaces Google DNS servers with `127.0.0.1` and `::1` addresses.

See: [patch_localhost-dns_ntp_gps.patch](lineage_src_root/patch_localhost-dns_ntp_gps.patch), and the article [Fjortek.com - Enforced, encrypted, self-hosted DNS solution for Android devices](https://fjordtek.com/categories/news/2021/enforced-encrypted-self-hosted-dns-solution-for-android-devices/).

### Bromite webview

Replaces built-in, prebuild Google Chromium webview with [Bromite webview](https://github.com/bromite/bromite).

See: [chromium-webview/Android.mk](lineage_src_root/external/chromium-webview/Android.mk)

### Default input method: Replace LatinIME

**1)** Download privacy friendly [simple-keyboard](https://github.com/rkkr/simple-keyboard/) and put source files into a new folder `packages/inputmethods/simple-keyboard/`

**2)** Get [Android.mk](lineage_src_root/packages/inputmethods/simple-keyboard/Android.mk) and [CleanSpec.mk](lineage_src_root/packages/inputmethods/simple-keyboard/CleanSpec.mk) for simple-keyboard. Put the files into the root folder of downloaded `simple-keyboard` source files.

**3)** Remove default input method `LatinIME` from AOSP 11 compilation process by commenting out lines

```
PRODUCT_PACKAGES += \
    LatinIME
```

in `build/make/target/product/handheld_product.mk`

**4)** You need to add lines

```
PRODUCT_PACKAGES += \
    SimpleKeyboard
```

into some `.mk` file of your choice.
