PKGNAME=man-pages
PKGVER=4.02
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
