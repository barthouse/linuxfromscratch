PKGNAME=procps-ng
PKGVER=3.3.11
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

./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/procps-ng-3.3.11 \
            --disable-static                         \
            --disable-kill

make

sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
make check

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

cd ..

rm -r -f $SRCDIR

