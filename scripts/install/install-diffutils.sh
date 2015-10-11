PKGNAME=diffutils
PKGVER=3.3
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in \
    1> $CONFIGLOG 2> $CONFIGERR

./configure --prefix=/usr \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
