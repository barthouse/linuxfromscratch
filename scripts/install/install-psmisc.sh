PKGNAME=psmisc
PKGVER=22.21
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/bin/fuser   /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/killall /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
