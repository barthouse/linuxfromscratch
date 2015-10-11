PKGNAME=make
PKGVER=4.1
TAREXT=bz2

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'CONFIG'

./configure --prefix=/tools --without-guile \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh
