PKGNAME=gcc
PKGVER=5.2.0
TAREXT=bz2

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

mkdir -v ../$PKGNAME-build
cd ../$PKGNAME-build

echo 'CONFIG'

../gcc-5.2.0/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/5.2.0 \
     1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh

