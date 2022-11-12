#!/bin/bash

# VARIABLES
INSTALL_D=toolchain
V10_2="10.2-2020.11"
V10_3="10.3-2021.07"

#Setting the VERSION
VERSION=$V10_2

LINK_ARM_AArch64_GNULinux_TARGET_VERSION="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/$VERSION/binrel"
FILE_ARM_AArch64_GNULinux_TARGET_VERSION="gcc-arm-$VERSION-x86_64-aarch64-none-linux-gnu"

#Download ARM cross compile toolchain
echo "- Downloading $FILE_ARM_AArch64_GNULinux_TARGET_VERSION file"
curl -o $FILE_ARM_AArch64_GNULinux_TARGET_VERSION.tar.xz $LINK_ARM_AArch64_GNULinux_TARGET_VERSION/$FILE_ARM_AArch64_GNULinux_TARGET_VERSION.tar.xz
echo "- Downloading $FILE_ARM_AArch64_GNULinux_TARGET_VERSION md5"
curl -o $FILE_ARM_AArch64_GNULinux_TARGET_VERSION.asc $LINK_ARM_AArch64_GNULinux_TARGET_VERSION/$FILE_ARM_AArch64_GNULinux_TARGET_VERSION.tar.xz.asc


#Install
echo "-Checking md5 checksum..."
md5sum --check $FILE_ARM_AArch64_GNULinux_TARGET_VERSION.asc
if [ $? -eq 0 ]
then
    mkdir -p $INSTALL_D
    tar -xJf $FILE_ARM_AArch64_GNULinux_TARGET_VERSION.tar.xz -C $INSTALL_D/
    echo "$INSTALL_D installed."
fi

echo "Do you want to add it to your PATH?"
read -p "Enter [y] or [n]: " set_path_var

if [ -d $INSTALL_D/$FILE_ARM_AArch64_GNULinux_TARGET_VERSION ] && ([ $set_path_var == 'y' ]  || [ $set_path_var == 'Y' ])
then
    echo "Add the next line to your bashrc file:"
    echo -e "\n  export PATH=\$PATH:`pwd`/$INSTALL_D/$FILE_ARM_AArch64_GNULinux_TARGET_VERSION/bin\n"
fi

echo -e "Printing version, configuration and sysroot path in cross-compile.txt...\n"
aarch64-none-linux-gnu-gcc -print-sysroot -v > assignment2/cross-compile.txt 2>&1
cat assignment2/cross-compile.txt
