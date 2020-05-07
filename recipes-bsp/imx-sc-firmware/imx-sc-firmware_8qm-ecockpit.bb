# Copyright (C) 2016 Freescale Semiconductor
# Copyright 2017-2020 NXP

DESCRIPTION = "i.MX System Controller Firmware"
LICENSE = "Proprietary"
SECTION = "BSP"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit fsl-eula2-unpack2 pkgconfig deploy autotools

SRC_URI = "file://scfw_export_mx8qm_b0.tar.gz \
           file://mek_ecockpit.patch"

S = "${WORKDIR}/scfw_export_mx8qm_b0"

SC_FIRMWARE_NAME = "scfw_tcm.bin"
BOOT_TOOLS = "imx-boot-tools"

do_compile() {
	cd ${S}
    # TODO: Change the path to installed Cortex-M4 toolchain
	export TOOLS="/opt"
	FLAGS="-DECOCKPIT_M4_0  -DECOCKPIT_M4_1" make qm B=mek_eco M=0 X=1 U=0 R=B0
}
do_install () {
    install -d ${STAGING_DIR}/boot
    install -m 0755 ${S}/build_mx8qm_b0/${SC_FIRMWARE_NAME} ${STAGING_DIR}/boot/${SC_FIRMWARE_NAME}
}

do_deploy () {
    install -d ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}
    install -m 0755 ${S}/build_mx8qm_b0/${SC_FIRMWARE_NAME} ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME}

}

addtask deploy after do_install

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
PACKAGE_ARCH = "${MACHINE_ARCH}"

FILES_{PN} = "/boot"

COMPATIBLE_MACHINE = "(mx8qm)"

