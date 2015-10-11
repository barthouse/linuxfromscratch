PKGNAME=procps-ng
PKGVER=3.3.11
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/procps-ng-3.3.11 \
            --disable-static                         \
            --disable-kill                           \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp \
    1> $TESTLOG 2> $TESTERR

make check \
    1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

if [ -h /usr/lib/libprocps.so ] 
then
    mv -v /usr/lib/libprocps.so.* /lib \
        1>> $INSTALLLOG 2>> $INSTALLERR

    ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) \
            /usr/lib/libprocps.so \
        1>> $INSTALLLOG 2>> $INSTALLERR
else
    echo 'build failed'
fi

source $DIR/docleanup.sh
