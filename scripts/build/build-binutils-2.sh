PKGNAME=binutils
PKGVER=2.25.1
TAREXT=bz2

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

mkdir -v ../$PKGNAME-build
cd ../$PKGNAME-build

echo 'CONFIG'

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../binutils-2.25.1/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot             \
     1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

make -C ld clean

echo 'MAKE LD'

make -C ld LIB_PATH=/usr/lib:/lib \
      1> ..\log\ld-make.log 2> ..\log\ld-make.err

cp -v ld/ld-new /tools/bin

source $BUILD/docleanup.sh

