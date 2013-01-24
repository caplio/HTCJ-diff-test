#!/bin/sh
##
## zImage to boot.img test script...
## 

## delete *.ko files
rm ./boot.img-ramdisk/lib/modules/*

# copy *.ko file to <ramdisk>/lib/modules
find -name '*.ko' ! -path "*boot.img-ramdisk*" -exec cp -av {} ./boot.img-ramdisk/lib/modules \;
cp ./boot.img-ramdisk/vendor/* ./boot.img-ramdisk/lib/modules/
# ramdisk copy to tmp dir
mkdir tmp
cp -pr ./boot.img-ramdisk ./tmp/boot.img-ramdisk
# rm .gitignore
find ./tmp -name '*.gitignore' -print | xargs rm

# create boot image >> output dir
./build-tools/repack-bootimg.pl arch/arm/boot/zImage ./tmp/boot.img-ramdisk ./output/boot`date +%m%d`-`cat .version`.img

# delete tmp dir
rm -r ./tmp/boot.img-ramdisk ./tmp
echo "output to ./output/boot`date +%m%d`-`cat .version`.img"
