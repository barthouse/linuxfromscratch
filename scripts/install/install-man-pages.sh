PKGNAME=man-pages
PKGVER=4.02
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

make install

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cd ..

rm -r -f $SRCDIR

