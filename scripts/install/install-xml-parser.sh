PKGNAME=XML-Parser
PKGVER=2.44
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'MAKE'

perl Makefile.PL \
    1> $MAKELOG 2> $MAKEERR

make \
    1>> $MAKELOG 2>> $MAKEERR

echo 'MAKE TESTS'

make test \
    1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh
