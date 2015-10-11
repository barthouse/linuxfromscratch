PKGNAME=expect
PKGVER=5.45
TAREXT=gz

source $BUILD/dosetup.sh

SRCDIR=$PKGNAME$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

source $BUILD/dotar.sh

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

echo 'CONFIG'

./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TEST'

make test 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make SCRIPTS="" install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh

