# Copyright (C) 2013-2016 Freescale Semiconductor
# Copyright 2017-2020 NXP

DESCRIPTION = "i.MX U-Boot suppporting i.MX reference boards."

require recipes-bsp/u-boot/u-boot.inc
inherit pythonnative

PROVIDES_remove = "virtual/bootloader"
DEPENDS_append = " flex-native bison-native python dtc-native imx-seco imx-sc-firmware"
do_compile[depends] += "imx-seco:do_deploy"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"

S = "${WORKDIR}/git"

inherit fsl-u-boot-localversion

LOCALVERSION ?= "-${SRCBRANCH}"

UBOOT_CONFIG = "a72"
UBOOT_CONFIG[a72] ?= "imx8qm_mek_a72_defconfig"

BOOT_TOOLS = "imx-boot-tools"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx6|mx7|mx8)"

UBOOT_NAME_mx6 = "u-boot-${MACHINE}.bin-${UBOOT_CONFIG}"
UBOOT_NAME_mx7 = "u-boot-${MACHINE}.bin-${UBOOT_CONFIG}"
UBOOT_NAME_mx8 = "u-boot-${MACHINE}.bin-${UBOOT_CONFIG}"
SPL_BINARY = "spl/u-boot-spl.bin"
BOOT_TOOLS = "imx-boot-tools"

do_compile_prepend() {
    cp ${DEPLOY_DIR_IMAGE}/mx8qmb0-ahab-container.img ${S}/ahab-container.img
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/scfw_tcm.bin ${S}/mx8qm-mek-scfw-tcm.bin
}