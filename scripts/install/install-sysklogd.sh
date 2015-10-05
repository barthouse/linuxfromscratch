PKGNAME=sysklogd
PKGVER=1.5.1
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

sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c

make

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make BINDIR=/sbin install

cd ..

rm -r -f $SRCDIR

