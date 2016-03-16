#!/bin/bash

#case "$1" in
#         H)
#            VARIANT=""
#            ;;
#
#         F)
#            VARIANT=""
#            ;;
#
#         *)
#            VARIANT=""
#esac

rm -rf $(pwd)/output/arch/arm/boot/dts/*
rm -f $(pwd)/output/arch/arm/boot/dt.img

export ARCH=arm
export CROSS_COMPILE=arm-eabi-
mkdir output

make -C $(pwd) O=output cyanogen_a5ultexx_defconfig
make -j5 -C $(pwd) O=output

#$(pwd)/dtbTool -2 -o $(pwd)/output/arch/arm/boot/dt.img -s 2048 -p $(pwd)/output/scripts/dtc/ $(pwd)/output/arch/arm/boot/dts/ -v
cp output/arch/arm/boot/zImage $(pwd)/zImage
