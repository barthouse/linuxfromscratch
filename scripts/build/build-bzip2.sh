PKGNAME=bzip2
PKGVER=1.0.6
TAREXT=gz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make PREFIX=/tools install 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh
