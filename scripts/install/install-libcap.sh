PKGNAME=libcap
PKGVER=2.24
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i '/install.*STALIBNAME/d' libcap/Makefile \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make RAISE_SETFCAP=no prefix=/usr install \
    1> $INSTALLLOG 2> $INSTALLERR

chmod -v 755 /usr/lib/libcap.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/lib/libcap.so.* /lib \
    1>> $INSTALLLOG 2>> $INSTALLERR

ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
