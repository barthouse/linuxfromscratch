PKGNAME=linux
PKGVER=4.2
TAREXT=xz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'MAKE'

make mrproper 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make INSTALL_HDR_PATH=dest headers_install 1> $INSTALLLOG 2> $INSTALLERR
cp -rv dest/include/* /tools/include

source $BUILD/docleanup.sh

