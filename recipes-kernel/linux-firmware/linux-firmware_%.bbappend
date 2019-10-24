FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://brcmfmac43430-sdio.txt \
"

do_install_append() {
    install -d ${D}${nonarch_base_libdir}/firmware/brcm/
    install -m 0644 ${WORKDIR}/brcmfmac43430-sdio.txt ${D}${nonarch_base_libdir}/firmware/brcm/
}

FILES_${PN}-bcm43430_append = " \
    ${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.txt \
"
