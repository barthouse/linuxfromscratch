PKGNAME=mpfr
PKGVER=3.1.3
TAREXT=xz
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

patch -Np1 -i ../mpfr-3.1.3-upstream_fixes-1.patch

./configure --prefix=/usr --disable-static --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.3

make
make html

make check

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install
make install-html

cd ..

rm -r -f $SRCDIR

