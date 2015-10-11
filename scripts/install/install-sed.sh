PKGNAME=sed
PKGVER=4.2.2
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2 \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

make html \
    1>> $MAKELOG 2>> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

make -C doc install-html \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
