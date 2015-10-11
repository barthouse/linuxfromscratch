PKGNAME=automake
PKGVER=1.15
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i 's:/\\\${:/\\\$\\{:' bin/automake.in \
    1> $CONFIGLOG 2> $CONFIGERR

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15 \
    1>> $CONFIGLOG 2>> $CONFIGERR

./configure --prefix=/usr \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh \
    1> $TESTLOG 2> $TESTERR

make -j4 check \
    1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
