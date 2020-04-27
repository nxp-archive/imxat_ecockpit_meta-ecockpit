do_copy_defconfig () {
    install -d ${B}
    # copy latest defconfig to use for mx8
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/ecockpit_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/ecockpit_defconfig ${B}/../defconfig
}
