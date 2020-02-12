FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_clockwork-cpi3 = " \
    file://0002-backlight-KD027-support.patch \
    file://0003-backlight-OCP8178-support.patch \
    file://0004-drm-Support-panel-simple-for-clockwork-cpi3.patch \
    file://0005-arm-dts-and-config-for-sun8i-r16-clockworkpi-cpi3.patch \
    file://0006-clockworkpi_cpi3_defconfig-updated-for-5.2-rc7.patch \
    file://logo_linux_clut224.ppm \
"
