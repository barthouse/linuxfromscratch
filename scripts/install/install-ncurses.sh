PKGNAME=ncurses
PKGVER=6.0
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in \
            1> $CONFIGLOG 2> $CONFIGERR

./configure --prefix=/usr \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --enable-pc-files       \
            --enable-widec          \
            1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/lib/libncursesw.so.6* /lib
    1>> $INSTALLLOG 2>> $INSTALLERR

ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so \
        1>> $INSTALLLOG 2>> $INSTALLERR
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc \
        1>> $INSTALLLOG 2>> $INSTALLERR
done

rm -vf                     /usr/lib/libcursesw.so \
    1>> $INSTALLLOG 2>> $INSTALLERR
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

mkdir -v       /usr/share/doc/ncurses-6.0 \
    1>> $INSTALLLOG 2>> $INSTALLERR
cp -v -R doc/* /usr/share/doc/ncurses-6.0 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh

