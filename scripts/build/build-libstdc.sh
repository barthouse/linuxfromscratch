# bzip2 -cd gcc-5.2.0.tar.bz2 | tar xvf -

# mkdir -v gcc-build

cd gcc-build

../gcc-5.2.0/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/5.2.0

make

make install

cd ..

rm -r -f gcc-build

rm -r -f gcc-5.2.0
