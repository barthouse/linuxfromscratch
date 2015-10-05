bzip2 -cd binutils-2.25.1.tar.bz2 | tar xvf -

mkdir -v binutils-build

cd binutils-build

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../binutils-2.25.1/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot

make

make install

make -c ld clean

make -c ld LIB_PATH=/usr/lib:/lib

cp -v ld/ld-new /tools/bin

cd ..

rm -r -f binutils-build

rm -r -f binutils-2.25.1
