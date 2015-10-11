PKGNAME=man-db
PKGVER=2.7.2
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.7.2 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap            \
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

source $DIR/docleanup.sh
