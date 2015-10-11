SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

TARLOG=install-log/$PKGNAME-tar.log
TARERR=install-log/$PKGNAME-tar.err
CONFIGLOG=../install-log/$PKGNAME-config.log
CONFIGERR=../install-log/$PKGNAME-config.err
MAKELOG=../install-log/$PKGNAME-make.log
MAKEERR=../install-log/$PKGNAME-make.err
INSTALLLOG=../install-log/$PKGNAME-install.log
INSTALLERR=../install-log/$PKGNAME-install.err
TESTLOG=../install-log/$PKGNAME-test.log
TESTERR=../install-log/$PKGNAME-test.err
PATCHLOG=../install-log/$PKGNAME-patch.log
PATCHERR=../install-log/$PKGNAME-patch.err

rm -r -f install-log
mkdir install-log
