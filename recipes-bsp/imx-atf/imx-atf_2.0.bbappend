do_compile_prepend() {
    export ECOCKPIT_A53=1
}

do_compile_append() {
    unset ECOCKPIT_A53
    export ECOCKPIT_A72=1
    oe_runmake BUILD_BASE=build-a72 bl31

    if [ "${BUILD_OPTEE}" = "true" ]; then
        oe_runmake clean BUILD_BASE=build-optee-a72
        oe_runmake BUILD_BASE=build-optee-a72 SPD=opteed bl31
    fi
    unset ECOCKPIT_A72
}

do_deploy_append() {
    install -m 0644 ${S}/build-a72/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-${PLATFORM}.bin-a72
    if [ "${BUILD_OPTEE}" = "true" ]; then
        install -m 0644 ${S}/build-optee-a72/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-${PLATFORM}.bin-optee-a72
    fi
}
