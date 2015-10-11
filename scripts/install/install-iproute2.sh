PKGNAME=iproute2
PKGVER=4.2.0
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i '/^TARGETS/s@arpd@@g' misc/Makefile \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i /ARPD/d Makefile \
    1>> $CONFIGLOG 2>> $CONFIGERR

sed -i 's/arpd.8//' man/man8/Makefile \
    1>> $CONFIGLOG 2>> $CONFIGERR

./configure --prefix=/usr \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make DOCDIR=/usr/share/doc/iproute2-4.2.0 install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
