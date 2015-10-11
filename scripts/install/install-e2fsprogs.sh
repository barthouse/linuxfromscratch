PKGNAME=e2fsprogs
PKGVER=1.42.13
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

mkdir -v build
cd build

LIBS=-L/tools/lib                    \
CFLAGS=-I/tools/include              \
PKG_CONFIG_PATH=/tools/lib/pkgconfig \
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck          \
    1> ../$CONFIGLOG 2> ../$CONFIGERR

echo 'MAKE'

make \
    1> ../$MAKELOG 2> ../$MAKEERR

echo 'MAKE TESTS'

ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib \
    1> ../$TESTLOG 2> ../$TESTERR

make LD_LIBRARY_PATH=/tools/lib check \
    1>> ../$TESTLOG 2>> ../$TESTERR

echo 'MAKE INSTALL'

make install \
    1> ../$INSTALLLOG 2> ../$INSTALLERR

make install-libs \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

gunzip -v /usr/share/info/libext2fs.info.gz \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

install -v -m644 doc/com_err.info /usr/share/info \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info \
    1>> ../$INSTALLLOG 2>> ../$INSTALLERR

cd ..

source $DIR/docleanup.sh
