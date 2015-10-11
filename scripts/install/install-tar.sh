PKGNAME=tar
PKGVER=1.28
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

make -C doc install-html docdir=/usr/share/doc/tar-1.28 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
