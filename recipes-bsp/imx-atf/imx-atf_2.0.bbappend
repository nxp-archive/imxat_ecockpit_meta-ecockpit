do_compile_prepend() {
    export ECOCKPIT_A53=1
}

do_compile_append() {
    export CROSS_COMPILE="${TARGET_PREFIX}"
    unset ECOCKPIT_A53
    export ECOCKPIT_A72=1
    oe_runmake ${BUILD_STRING} PLAT=${SOC_ATF} BUILD_BASE=build-a72 bl31
    unset ECOCKPIT_A72
    unset CROSS_COMPILE
}

do_install_append() {
    install -m 0644 ${S}/build-a72/${SOC_ATF}/release/bl31.bin ${D}/boot/bl31-${SOC_ATF}.bin-a72
}

do_deploy_append() {
    install -m 0644 ${S}/build-a72/${SOC_ATF}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-${SOC_ATF}.bin-a72
}
