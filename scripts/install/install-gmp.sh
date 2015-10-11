PKGNAME=gmp
PKGVER=6.0.0a
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

SRCDIR=gmp-6.0.0

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.0.0a \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR
make html 1>> $MAKELOG 2>> $MAKEERR

echo 'MAKE TESTS'

make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR
make install-html 1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
