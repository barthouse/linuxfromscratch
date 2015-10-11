PKGNAME=tcl-core
PKGVER=8.6.4
TAREXT=gz

source $BUILD/dosetup.sh

TARFILE=$PKGNAME$PKGVER-src.tar.$TAREXT
SRCDIR=tcl$PKGVER

source $BUILD/dotar.sh

# mkdir -v ../$PKGNAME-build
# cd ../$PKGNAME-build

cd unix

echo 'CONFIG'

./configure     \
    --prefix=/tools            \
     1> ../$CONFIGLOG 2> ../$CONFIGERR

echo 'MAKE'

make 1> ..\$MAKELOG 2> ..\$MAKEERR

echo 'MAKE TEST'

TZ=UTC make test 1> ../$TESTLOG 2> ../$TESTERR 

echo 'MAKE INSTALL'

make install 1> ../$INSTALLLOG 2> ../$INSTALLERR

chmod -v u+w /tools/lib/libtcl8.6.so

echo 'MAKE INSTALL HEADERS'

make install-private-headers \
    1> ../../log/$PKGNAME-install-headers.log \
    2> ../../log/$PKGNAME-install-headers.err

ln -sv tclsh8.6 /tools/bin/tclsh

cd ..

source $BUILD/docleanup.sh

