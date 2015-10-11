PKGNAME=binutils
PKGVER=2.25.1
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

source $DIR/dobuilddir.sh

echo 'CONFIG'

../binutils-2.25.1/configure --prefix=/usr \
                           --enable-shared \
                           --disable-werror \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make tooldir=/usr 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make tooldir=/usr install 1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
