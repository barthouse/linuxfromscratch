PKGNAME=util-linux
PKGVER=2.27
TAREXT=xz
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

case $TAREXT in
    "gz") tar -zxvf $TARFILE
          break;;
    "xz") tar -Jxvf $TARFILE
          break;;
    "bz2") tar -jxvf $TARFILE
          break;;
    *) echo "unrecognized tar extension"
          exit;; 
esac

cd $SRCDIR

./configure --prefix=/tools --without-python --disable-makeinstall-chown \
            --without-systemdsystemunitdir Pkg_CONFIG=""

make

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

cd ..

rm -r -f $SRCDIR
