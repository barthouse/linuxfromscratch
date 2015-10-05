PKGNAME=acl
PKGVER=2.2.52
TAREXT=gz
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.src.tar.$TAREXT

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

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test

sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c

./configure --prefix=/usr    \
            --bindir=/bin    \
            --disable-static \
            --libexecdir=/usr/lib

make

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install install-dev install-lib
chmod -v 755 /usr/lib/libacl.so

mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so

cd ..

rm -r -f $SRCDIR

