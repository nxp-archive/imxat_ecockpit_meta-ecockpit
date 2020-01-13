IMXBOOT_TARGETS = "flash_ecockpit_b0_m4"

do_compile[depends] += "u-boot-imx-a72:do_deploy"

compile_mx8 () {
    bbnote 8QM boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME} ${BOOT_STAGING}/scfw_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin

    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME}-a72    ${BOOT_STAGING}/bl31-a72.bin
    cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin-a72                ${BOOT_STAGING}/u-boot-a72.bin

    cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_0_TCM_rpmsg_lite_pingpong_rtos_linux_remote_m40.bin ${BOOT_STAGING}/m40_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_1_TCM_rpmsg_lite_pingpong_rtos_linux_remote_m41.bin ${BOOT_STAGING}/m41_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_0_TCM_rpmsg_lite_pingpong_rtos_linux_remote_m40.bin ${BOOT_STAGING}/m4_image.bin
    cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_1_TCM_rpmsg_lite_pingpong_rtos_linux_remote_m41.bin ${BOOT_STAGING}/m4_1_image.bin

    cp ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE} ${BOOT_STAGING}
}
