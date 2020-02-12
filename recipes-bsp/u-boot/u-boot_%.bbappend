FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-cpi3-dts-makefile.patch \
            file://clockworkpi_cpi3_defconfig \
            file://sun8i-r16-clockworkpi-cpi3.dts \
            file://sun8i-r16-clockworkpi-cpi3-hdmi.dts \
            "

do_configure_prepend() {
    cp -v ${WORKDIR}/clockworkpi_cpi3_defconfig ${S}/configs/clockworkpi_cpi3_defconfig
    cp -v ${WORKDIR}/*.dts ${S}/arch/arm/dts/
}
