PKGNAME=binutils
PKGVER=2.25.1
TAREXT=bz2

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

mkdir -v ../$PKGNAME-build
cd ../$PKGNAME-build

echo 'CONFIG'

../binutils-2.25.1/configure     \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror           \
     1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh

