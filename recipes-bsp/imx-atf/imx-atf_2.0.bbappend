do_compile_prepend() {
    export ECOCKPIT_A53=1
}

do_compile_append() {
    unset ECOCKPIT_A53
    export ECOCKPIT_A72=1
    oe_runmake BUILD_BASE=build-a72 SPD=none bl31
    unset ECOCKPIT_A72
}

do_deploy_append() {
    install -m 0644 ${S}/build-a72/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/${BOOT_TOOLS}/bl31-${PLATFORM}.bin-a72
}
