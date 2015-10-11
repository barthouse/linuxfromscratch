PKGNAME=bzip2
PKGVER=1.0.6
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch \
    1> $PATCHLOG 2> $PATCHERR

echo 'CONFIG'

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile \
    1>> $CONFIGLOG 2>> $CONFIGERR

make -f Makefile-libbz2_so 1> $CONFIGLOG 2> $CONFIGERR \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make clean 1> $MAKELOG 2> $MAKEERR

make 1>> $MAKELOG 2>> $MAKEERR

echo 'MAKE INSTALL'

make PREFIX=/usr install 1> $INSTALLLOG 2> $INSTALLERR

cp -v bzip2-shared /bin/bzip2 1>> $INSTALLLOG 2>> $INSTALLERR
cp -av libbz2.so* /lib 1>> $INSTALLLOG 2>> $INSTALLERR
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so \
    1>> $INSTALLLOG 2>> $INSTALLERR
rm -v /usr/bin/{bunzip2,bzcat,bzip2} 1>> $INSTALLLOG 2>> $INSTALLERR
ln -sv bzip2 /bin/bunzip2 1>> $INSTALLLOG 2>> $INSTALLERR
ln -sv bzip2 /bin/bzcat 1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
