PKGNAME=mpfr
PKGVER=3.1.3
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

patch -Np1 -i ../mpfr-3.1.3-upstream_fixes-1.patch

echo 'CONFIG'

./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.3 \
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
