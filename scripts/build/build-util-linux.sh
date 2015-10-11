PKGNAME=util-linux
PKGVER=2.27
TAREXT=xz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'CONFIG'

./configure --prefix=/tools \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG="" \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh
