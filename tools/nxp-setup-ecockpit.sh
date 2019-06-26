#!/bin/sh
#
# NXP Build Enviroment Setup Script
#
# Copyright (C) 2015-2016 Freescale Semiconductor
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

echo -e "\n----------------\n"
ecockpit_exit_message()
{
   echo "eCockpit setup complete"
}

ecockpit_usage()
{
    echo -e "\nDescription: nxp-setup-ecockpit.sh will setup the bblayers and local.conf for an eCockpit build."
    echo -e "\nUsage: source nxp-setup-ecockpit.sh
    Optional parameters: [-b build-dir] [-h]"
    echo "
    * [-b build-dir]: Build directory, if unspecified, script uses 'build-ecockpit' as the output directory
    * [-h]: help
"
}

ecockpit_cleanup()
{
    echo "Cleaning up variables"
    unset nxp_setup_help nxp_setup_error nxp_setup_flag
    unset ecockpit_usage ecockpit_cleanup ecockpit_exit_message
}

echo Reading command line parameters
# Read command line parameters
while getopts "k:r:t:b:e:gh" nxp_setup_flag
do
    case $nxp_setup_flag in
        b) BUILD_DIR="$OPTARG";
           echo -e "\n Build directory is $BUILD_DIR" ;
           ;;
        h) nxp_setup_help='true';
           ;;
        ?) nxp_setup_error='true';
           ;;
    esac
done

RELEASEPROGNAME="./fsl-setup-release.sh"

# get command line options
OLD_OPTIND=$OPTIND

if [ -z "$BUILD_DIR" ]; then
    BUILD_DIR=build-ecockpit
fi

echo EULA=1 MACHINE=$MACHINE DISTRO=$DISTRO source $RELEASEPROGNAME -b $BUILD_DIR
EULA=1 MACHINE=$MACHINE DISTRO=$DISTRO source $RELEASEPROGNAME -b $BUILD_DIR

echo -e "\n## eCockpit Repositories" >> $BUILD_DIR/conf/local.conf
echo -e "ECOCKPIT_MIRROR = \"git://bitbucket.sw.nxp.com/mss\"" >> $BUILD_DIR/conf/local.conf
echo -e "ECOCKPIT_BRANCH = \"ecockpit_4.14.98_2.0.0_ga-dev\"" >> $BUILD_DIR/conf/local.conf

echo -e "\nATF_SRC = \"\${ECOCKPIT_MIRROR}/arm-trusted-firmware-ecockpit.git;protocol=ssh\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCBRANCH_pn-imx-atf = \"\${ECOCKPIT_BRANCH}\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCREV_pn-imx-atf = \"bde0b97702e87db3d8a4dba35df865beeb731955\"" >> $BUILD_DIR/conf/local.conf

echo -e "\nUBOOT_SRC = \"\${ECOCKPIT_MIRROR}/uboot-ecockpit.git;protocol=ssh\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCBRANCH_pn-u-boot-imx = \"\${ECOCKPIT_BRANCH}\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCREV_pn-u-boot-imx = \"3eaf5b9d4d12540f492ac8a6d2530990997befc0\"" >> $BUILD_DIR/conf/local.conf

echo -e "\nIMX_MKIMAGE_SRC = \"\${ECOCKPIT_MIRROR}/imx-mkimage-ecockpit.git;protocol=ssh\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCBRANCH_pn-imx-boot = \"\${ECOCKPIT_BRANCH}\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCREV_pn-imx-boot = \"f7aa66b4a45facc927221fed4eb5139a7e123398\"" >> $BUILD_DIR/conf/local.conf

echo -e "\nKERNEL_SRC = \"\${ECOCKPIT_MIRROR}/linux-ecockpit.git;protocol=ssh\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCBRANCH_pn-linux-imx = \"\${ECOCKPIT_BRANCH}\"" >> $BUILD_DIR/conf/local.conf
echo -e "SRCREV_pn-linux-imx = \"d339fc0f291cf154eb6fe1404937131c98f5bf98\"" >> $BUILD_DIR/conf/local.conf

echo -e "\nPREFERRED_VERSION_imx-sc-firmware = \"8qm-ecockpit\"" >> $BUILD_DIR/conf/local.conf

echo -e "\n## eCockpit layer" >> $BUILD_DIR/conf/bblayers.conf
hook_in_layer meta-ecockpit meta-fsl-bsp-release/imx/meta-bsp

echo done except for cleanup

ecockpit_exit_message
ecockpit_cleanup

