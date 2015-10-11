PKGNAME=eudev
PKGVER=3.1.2
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl \
    1> $CONFIGLOG 2> $CONFIGERR

cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF

./configure --prefix=/usr           \
            --bindir=/sbin          \
            --sbindir=/sbin         \
            --libdir=/usr/lib       \
            --sysconfdir=/etc       \
            --libexecdir=/lib       \
            --with-rootprefix=      \
            --with-rootlibdir=/lib  \
            --enable-split-usr      \
            --enable-manpages       \
            --enable-hwdb           \
            --disable-introspection \
            --disable-gudev         \
            --disable-static        \
            --config-cache          \
            --disable-gtk-doc-html  \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

LIBRARY_PATH=/tools/lib make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

mkdir -pv /lib/udev/rules.d \
    1> $TESTLOG 2> $TESTERR

mkdir -pv /etc/udev/rules.d \
    1>> $TESTLOG 2>> $TESTERR

make LD_LIBRARY_PATH=/tools/lib check \
    1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make LD_LIBRARY_PATH=/tools/lib install \
    1> $INSTALLLOG 2> $INSTALLERR

tar -xvf ../udev-lfs-20140408.tar.bz2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

make -f udev-lfs-20140408/Makefile.lfs install \
    1>> $INSTALLLOG 2>> $INSTALLERR

LD_LIBRARY_PATH=/tools/lib udevadm hwdb --update \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
