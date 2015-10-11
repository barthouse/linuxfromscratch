PKGNAME=coreutils
PKGVER=8.24
TAREXT=xz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'CONFIG'

./configure --prefix=/tools \
            --enable-install-program=hostname \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make RUN_EXPENSIVE_TESTS=yes check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh
