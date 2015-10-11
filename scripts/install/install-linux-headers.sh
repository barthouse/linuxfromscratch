PKGNAME=linux
PKGVER=4.2
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'MAKE'

make mrproper 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make INSTALL_HDR_PATH=dest headers_install 1> $INSTALLLOG 2> $INSTALLERR

find dest/include \( -name .install -o -name ..install.cmd \) -delete \
    1> $INSTALLLOG 2> $INSTALLERR

cp -rv dest/include/* /usr/include 1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
