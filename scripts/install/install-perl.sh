PKGNAME=perl
PKGVER=5.22.0
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

exit

export BUILD_ZLIB=False \
    1> $CONFIGLOG 2> $CONFIGERR

export BUILD_BZIP2=0 \
    1>> $CONFIGLOG 2>> $CONFIGERR

sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib                  \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make -k test \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

unset BUILD_ZLIB BUILD_BZIP2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
