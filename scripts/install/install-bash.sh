PKGNAME=bash
PKGVER=4.3.30
TAREXT=gz
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

case $TAREXT in
    "gz") tar -zxvf $TARFILE
          ;;
    "xz") tar -Jxvf $TARFILE
          ;;
    "bz2") tar -jxvf $TARFILE
           ;;
    *) echo "unrecognized tar extension"
       exit
       ;; 
esac

cd $SRCDIR

patch -Np1 -i ../bash-4.3.30-upstream_fixes-2.patch

./configure --prefix=/usr                       \
            --bindir=/bin                       \
            --docdir=/usr/share/doc/bash-4.3.30 \
            --without-bash-malloc               \
            --with-installed-readline
make

chown -Rv nobody .

su nobody -s /bin/bash -c "PATH=$PATH make tests"

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

exec /bin/bash --login +h

cd ..

rm -r -f $SRCDIR

