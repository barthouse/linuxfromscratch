PKGNAME=kmod
PKGVER=21
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib            \
    1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target \
    1>> $INSTALLLOG 2>> $INSTALLERR
done

ln -sv kmod /bin/lsmod \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
