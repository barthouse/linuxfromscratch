PKGNAME=attr
PKGVER=2.4.47
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

TARFILE=$SRCDIR.src.tar.$TAREXT

source $DIR/dotar.sh

exit

echo 'CONFIG'

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in \
            1> $CONFIGLOG 2> $CONFIGERR

sed -i -e "/SUBDIRS/s|man2||" man/Makefile \
            1>> $CONFIGLOG 2>> $CONFIGERR

./configure --prefix=/usr \
            --bindir=/bin \
            --disable-static \
            1>> $CONFIGLOG 2>> $CONFIGERR


echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make -j1 tests root-tests 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install install-dev install-lib \
    1> $INSTALLLOG 2> $INSTALLERR

chmod -v 755 /usr/lib/libattr.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/lib/libattr.so.* /lib \
    1>> $INSTALLLOG 2>> $INSTALLERR

ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
