PKGNAME=bc
PKGVER=1.06.95
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'PATCH'

patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch \
    1> $PATCHLOG 2> $PATCHERR

echo 'CONFIG'

./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

echo "quit" | ./bc/bc -l Test/checklib.b \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
