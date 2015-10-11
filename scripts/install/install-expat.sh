PKGNAME=expat
PKGVER=2.1.0
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr --disable-static \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

install -v -dm755 /usr/share/doc/expat-2.1.0 \
    1>> $INSTALLLOG 2>> $INSTALLERR

install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.1.0 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
