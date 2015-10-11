PKGNAME=sysvinit
PKGVER=2.88dsf
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

patch -Np1 -i ../sysvinit-2.88dsf-consolidated-1.patch \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make -C src \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make -C src install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
