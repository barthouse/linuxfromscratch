PKGNAME=dejagnu
PKGVER=1.5.3
TAREXT=gz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'CONFIG'

./configure --prefix=/tools \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

echo 'MAKE CHECK'

make check 1> $TESTLOG 2> $TESTERR

source $BUILD/docleanup.sh

