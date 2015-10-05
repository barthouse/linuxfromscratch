PKGNAME=gzip
PKGVER=1.6
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.xz

# -z for .gz
# tar -zxvf $TARFILE

# -J for .xz
tar -Jxvf $TARFILE

cd $SRCDIR

./configure --prefix=/tools

make

make check

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

