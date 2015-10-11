PKGNAME=glibc
PKGVER=2.22
TAREXT=xz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

patch -Np1 -i ../glibc-2.22-upstream_i386_fix-1.patch

mkdir -v ../$PKGNAME-build
cd ../$PKGNAME-build

echo 'CONFIG'

../glibc-2.22/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.22/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes                         \
      1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh

