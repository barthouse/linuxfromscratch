PKGNAME=findutils
PKGVER=4.4.2
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr --localstatedir=/var/lib/locate \
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

mv -v /usr/bin/find /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
