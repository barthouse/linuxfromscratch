SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

TARLOG=build-log/$PKGNAME-tar.log
TARERR=build-log/$PKGNAME-tar.err
CONFIGLOG=../build-log/$PKGNAME-config.log
CONFIGERR=../build-log/$PKGNAME-config.err
MAKELOG=../build-log/$PKGNAME-make.log
MAKEERR=../build-log/$PKGNAME-make.err
INSTALLLOG=../build-log/$PKGNAME-install.log
INSTALLERR=../build-log/$PKGNAME-install.err
TESTLOG=../build-log/$PKGNAME-test.log
TESTERR=../build-log/$PKGNAME-test.err

rm -r -f build-log
mkdir build-log


