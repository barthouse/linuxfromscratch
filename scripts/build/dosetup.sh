SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

TARLOG=log/$PKGNAME-tar.log
TARERR=log/$PKGNAME-tar.err
CONFIGLOG=../log/$PKGNAME-config.log
CONFIGERR=../log/$PKGNAME-config.err
MAKELOG=../log/$PKGNAME-make.log
MAKEERR=../log/$PKGNAME-make.err
INSTALLLOG=../log/$PKGNAME-install.log
INSTALLERR=../log/$PKGNAME-install.err

rm -r -f log
mkdir log


