#!/bin/bash

rm -rf $(pwd)/output/arch/arm/boot/dts/*
rm -f $(pwd)/output/arch/arm/boot/dt.img
rm -r $(pwd)/../../kitchen/mkb/newcm13/zImage

export ARCH=arm
export CROSS_COMPILE=arm-eabi-
mkdir output

make -C $(pwd) O=output cyanogen_a5ultexx_defconfig
make -j5 -C $(pwd) O=output

#$(pwd)/../../kitchen/mkb/dtbToolCM -2 -o $(pwd)/output/arch/arm/boot/dt.img -s 2048 -p $(pwd)/output/scripts/dtc/ $(pwd)/output/arch/arm/boot/dts/ -v

cp output/arch/arm/boot/zImage $(pwd)/../../kitchen/mkb/newcm13/zImage

$(pwd)/../../kitchen/mkb/mkboot $(pwd)/../../kitchen/mkb/newcm13 $(pwd)/boot.img

rm -r $(pwd)/../../kitchen/kern/boot/boot.img

cp $(pwd)/boot.img $(pwd)/../../kitchen/kern/boot/boot.img

lol=$(pwd)

cd $(pwd)/../../kitchen/kern

rm -r $lol/output/kernel.zip

zip -r $lol/output/kernel.zip ./boot ./META-INF ./system

adb sideload $lol/output/kernel.zip

