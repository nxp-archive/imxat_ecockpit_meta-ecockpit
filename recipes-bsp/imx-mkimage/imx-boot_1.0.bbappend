IMXBOOT_TARGETS = "flash_ecockpit_b0_m4"

do_compile[depends] += "u-boot-imx-a72:do_deploy"
do_compile[depends] += "optee-os-a72:do_deploy"

compile_mx8_append () {
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/bl31-imx8qm.bin-a72    ${BOOT_STAGING}/bl31-a72.bin
    cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin-a72                ${BOOT_STAGING}/u-boot-a72.bin

    cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-a72 \
                                                             ${BOOT_STAGING}/u-boot-spl-a72.bin
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee-a72.bin                       ${BOOT_STAGING}
    fi
}

deploy_mx8_append() {
    if "${DEPLOY_OPTEE}"; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/tee-a72.bin          ${DEPLOYDIR}/${BOOT_TOOLS}
    fi
}
