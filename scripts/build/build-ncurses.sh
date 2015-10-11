PKGNAME=ncurses
PKGVER=6.0
TAREXT=gz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

sed -i s/mawk// configure

echo 'CONFIG'

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh

