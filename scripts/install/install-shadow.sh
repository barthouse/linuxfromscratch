PKGNAME=shadow
PKGVER=4.2.1
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

sed -i 's/groups$(EXEEXT) //' src/Makefile.in \
    1> $CONFIGLOG 2> $CONFIGERR

find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \; \
    1>> $CONFIGLOG 2>> $CONFIGERR

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs \
    1>> $CONFIGLOG 2>> $CONFIGERR

sed -i 's/1000/999/' etc/useradd \
    1> $CONFIGLOG 2> $CONFIGERR

./configure --sysconfdir=/etc --with-group-name-max-length=32 \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/bin/passwd /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
