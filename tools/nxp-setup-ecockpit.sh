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

echo -e "\n## eCockpit layer" >> $BUILD_DIR/conf/bblayers.conf
hook_in_layer meta-ecockpit meta-fsl-bsp-release/imx/meta-bsp

echo done except for cleanup

ecockpit_exit_message
ecockpit_cleanup

