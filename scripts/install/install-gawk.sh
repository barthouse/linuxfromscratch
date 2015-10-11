PKGNAME=gawk
PKGVER=4.1.3
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr \
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

mkdir -v /usr/share/doc/gawk-4.1.3 \
    1>> $INSTALLLOG 2>> $INSTALLERR

cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.1.3 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
