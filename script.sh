#!/bin/bash

#set -e

DATE_POSTFIX=$(date +"%Y%m%d")

## Copy this script inside the kernel directory
KERNEL_DIR=$PWD
KERNEL_TOOLCHAIN=$PWD/../../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
CLANG_TOOLCHAIN=$PWD/../../prebuilts-master/clang/host/linux-x86/clang-r353983c/bin/clang
KERNEL_DEFCONFIG=vendor/mh2lm-perf_defconfig
JOBS=4
KERNEL=Mayhem-KERNEL
# Speed up build process
MAKE="./makeparallel"

BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
#red
R='\033[05;31m'
#purple
P='\e[0;35m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

echo -e  "$P // Setting up Toolchain //"
export CROSS_COMPILE=$KERNEL_TOOLCHAIN
export KBUILD_BUILD_USER="Ronax"
export KBUILD_BUILD_HOST="Parallax-Machine"
export CLANG_TRIPLE=aarch64-linux-gnu-

echo -e  "$R // Cleaning up //"
make clean && make mrproper && rm -rf out/

echo -e "$cyan // defconfig is set to $KERNEL_DEFCONFIG //"
echo -e "$blue***********************************************"
echo -e "$R          BUILDING Mayhem-KERNEL          "
echo -e "***********************************************$nocol"
echo -e "$blue***********************************************"
echo -e "$R       ++++++||parallax plus||++++++                 "
echo -e "***********************************************$nocol"
make O=./out ARCH=arm64 $KERNEL_DEFCONFIG
make O=./out ARCH=arm64 REAL_CC=$CLANG_TOOLCHAIN -j4
