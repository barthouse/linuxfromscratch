PKGNAME=kbd
PKGVER=2.0.3
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

patch -Np1 -i ../kbd-2.0.3-backspace-1.patch \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure \
    1>> $CONFIGLOG 2>> $CONFIGERR

sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in \
    1>> $CONFIGLOG 2>> $CONFIGERR

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mkdir -v       /usr/share/doc/kbd-2.0.3 \
    1>> $INSTALLLOG 2>> $INSTALLERR

cp -R -v docs/doc/* /usr/share/doc/kbd-2.0.3 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
