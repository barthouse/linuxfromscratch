PKGNAME=acl
PKGVER=2.2.52
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

TARFILE=$PKGNAME-$PKGVER.src.tar.$TAREXT

source $DIR/dotar.sh

exit

echo 'CONFIG'

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test \
    1>> $CONFIGLOG 2>> $CONFIGERR

sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c \
    1>> $CONFIGLOG 2>> $CONFIGERR

./configure --prefix=/usr \
            --bindir=/bin    \
            --disable-static \
            --libexecdir=/usr/lib \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

exit

echo 'MAKE INSTALL'

make install install-dev install-lib \
    1> $INSTALLLOG 2> $INSTALLERR

chmod -v 755 /usr/lib/libacl.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/lib/libacl.so.* /lib \
    1>> $INSTALLLOG 2>> $INSTALLERR

ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
