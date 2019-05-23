SRCBRANCH = "ecockpit_4.14.78_1.0.0_EC53-dev"
LOCALVERSION = "-${SRCBRANCH}"
KERNEL_SRC = "git://bitbucket.sw.nxp.com/mss/linux-ecockpit.git;protocol=ssh"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV = "ecockpit_05_03"

do_copy_defconfig () {
    install -d ${B}
    # copy latest defconfig to use for mx8
    mkdir -p ${B}
    cp ${S}/arch/arm64/configs/ecockpit_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/ecockpit_defconfig ${B}/../defconfig
}
