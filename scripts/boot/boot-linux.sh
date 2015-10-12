PKGNAME=linux
PKGVER=4.2
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

make mrproper

cp $DIR/.config .config

# exit
# make LANG=en_US.ISO-8859-1 menuconfig

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make modules_install \
    1> $INSTALLLOG 2> $INSTALLERR

cp -v arch/x86/boot/bzImage /boot/vmlinuz-4.2-lfs-7.8 \
    1>> $INSTALLLOG 2>> $INSTALLERR

cp -v System.map /boot/System.map-4.2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

cp -v .config /boot/config-4.2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

install -d /usr/share/doc/linux-4.2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

cp -r Documentation/* /usr/share/doc/linux-4.2 \
    1>> $INSTALLLOG 2>> $INSTALLERR

chown -Rv 0:0 . \
    1>> $INSTALLLOG 2>> $INSTALLERR

install -v -m755 -d /etc/modprobe.d

cp $DIR\etc-modprobe /etc/modprobe.d/usb.conf

cd ..

mkdir -p install-log-sav
cp install-log/* install-log-sav

ls -l install-log
