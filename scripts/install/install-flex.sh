PKGNAME=flex
PKGVER=2.5.39
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i -e '/test-bison/d' tests/Makefile.in \
    1> $CONFIGLOG 2> $CONFIGERR

./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39 \
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

ln -sv flex /usr/bin/lex \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
