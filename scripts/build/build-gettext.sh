PKGNAME=gettext
PKGVER=0.19.5.1
TAREXT=xz

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

cd gettext-tools


echo 'CONFIG'

EMACS="no" ./configure --prefix=/tools --disable-shared \
            1> ../$CONFIGLOG 2> ../$CONFIGERR

echo 'MAKE'

make -C gnulib-lib 1> ../$MAKELOG 2> ../$MAKEERR
make -C intl pluralx.c 1>> ../$MAKELOG 2>> ../$MAKEERR
make -C src msgfmt 1>> ../$MAKELOG 2>> ../$MAKEERR
make -C src msgmerge 1>> ../$MAKELOG 2>> ../$MAKEERR
make -C src xgettext 1>> ../$MAKELOG 2>> ../$MAKEERR

#echo 'MAKE TESTS'

#make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

#make install 1> $INSTALLLOG 2> $INSTALLERR

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin 1> ../$INSTALLLOG 2> ../$INSTALLERR

cd ..

source $BUILD/docleanup.sh
