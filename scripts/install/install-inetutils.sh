PKGNAME=inetutils
PKGVER=1.9.4
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr        \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers    \
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

mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/ifconfig /sbin \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
