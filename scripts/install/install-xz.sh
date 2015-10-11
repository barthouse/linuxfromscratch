PKGNAME=xz
PKGVER=5.2.1
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.1 \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/lib/liblzma.so.* /lib \
    1>> $INSTALLLOG 2>> $INSTALLERR

if [ -h /usr/lib/liblzma.so ]
then
    ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so \
        1>> $INSTALLLOG 2>> $INSTALLERR
else
    echo 'Build failed'
fi

source $DIR/docleanup.sh
