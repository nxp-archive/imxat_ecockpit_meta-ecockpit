IMXBOOT_TARGETS = "flash_ecockpit_b0"
UBOOT_NAME = "u-boot-${MACHINE}.bin-a53"
BOOT_CONFIG_MACHINE = "${BOOT_NAME}-${MACHINE}.bin"

do_compile () {
    if [ "${SOC_TARGET}" = "iMX8QM" ]; then
        echo 8QM boot binary build
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME}        ${S}/${SOC_DIR}/scfw_tcm.bin
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME}        ${S}/${SOC_DIR}/bl31.bin
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME}-a72    ${S}/${SOC_DIR}/bl31-a72.bin
        cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin-a53                ${S}/${SOC_DIR}/u-boot.bin
        cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin-a72                ${S}/${SOC_DIR}/u-boot-a72.bin

        cp ${DEPLOY_DIR_IMAGE}/mx8qm-ahab-container.img ${S}/${SOC_DIR}/
    fi

    # mkimage for i.MX8
    for target in ${IMXBOOT_TARGETS}; do
        echo "building ${SOC_TARGET} - ${target}"
        make SOC=${SOC_TARGET} ${target}
        if [ -e "${S}/${SOC_DIR}/flash.bin" ]; then
            cp ${S}/${SOC_DIR}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}

do_deploy () {
    install -d ${DEPLOYDIR}/${DEPLOYDIR_IMXBOOT}

    # copy the tool mkimage to deploy path and sc fw, dcd and uboot
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME} ${DEPLOYDIR}/${DEPLOYDIR_IMXBOOT}
    if [ "${SOC_TARGET}" = "iMX8QM" ]; then
        if [ "${MACHINE}" = "imx8qma0mek" ]; then
            install -m 0644 ${S}/${SOC_DIR}/${DCD_NAME} ${DEPLOYDIR}/${DEPLOYDIR_IMXBOOT}
        fi
        install -m 0644 ${S}/${SOC_DIR}/mx8qm-ahab-container.img ${DEPLOYDIR}/${DEPLOYDIR_IMXBOOT}

        install -m 0755 ${S}/${TOOLS_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}
    fi

    # copy makefile (soc.mak) for reference
    install -m 0644 ${S}/${SOC_DIR}/soc.mak     ${DEPLOYDIR}/${DEPLOYDIR_IMXBOOT}

    # copy the generated boot image to deploy path
    for target in ${IMXBOOT_TARGETS}; do
        # Use first "target" as IMAGE_IMXBOOT_TARGET
        if [ "$IMAGE_IMXBOOT_TARGET" = "" ]; then
            IMAGE_IMXBOOT_TARGET="$target"
            echo "Set boot target as $IMAGE_IMXBOOT_TARGET"
        fi
        install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${DEPLOYDIR}
    done
    cd ${DEPLOYDIR}
    ln -sf ${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} ${BOOT_CONFIG_MACHINE}
    cd -
}
