PKGNAME=sysvinit
PKGVER=2.88dsf
TAREXT=bz2
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

patch -Np1 -i ../sysvinit-2.88dsf-consolidated-1.patch

make -C src

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make -C src install

cd ..

rm -r -f $SRCDIR

