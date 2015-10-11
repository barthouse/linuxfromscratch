PKGNAME=bash
PKGVER=4.3.30
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'PATCH'

patch -Np1 -i ../bash-4.3.30-upstream_fixes-2.patch \
    1> $PATCHLOG 2> $PATCHERR

echo 'CONFIG'

./configure --prefix=/usr                       \
            --bindir=/bin                       \
            --docdir=/usr/share/doc/bash-4.3.30 \
            --without-bash-malloc               \
            --with-installed-readline           \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

chown -Rv nobody . \
    1> $TESTLOG 2> $TESTERR

su nobody -s /bin/bash -c "PATH=$PATH make tests" \
    1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

source $DIR/docleanup.sh

echo 'You can now switch to new bash "exec /bin/bash --login +h"'

