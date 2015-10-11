PKGNAME=perl
PKGVER=5.22.0
TAREXT=bz2

source $BUILD/dosetup.sh

source $BUILD/dotar.sh

echo 'CONFIG'

sh Configure -des -Dprefix=/tools -Dlibs=-lm \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

cp -v perl cpan/podlators/pod2man /tools/bin 1> $INSTALLLOG 2> $INSTALLERR
mkdir -pv /tools/lib/perl5/5.22.0 1> $INSTALLLOG 2> $INSTALLERR
cp -Rv lib/* /tools/lib/perl5/5.22.0 1> $INSTALLLOG 2> $INSTALLERR

source $BUILD/docleanup.sh
