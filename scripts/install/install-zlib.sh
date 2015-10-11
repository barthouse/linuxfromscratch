PKGNAME=zlib
PKGVER=1.2.8
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

source $DIR/docleanup.sh
