PKGNAME=perl
PKGVER=5.22.0
TAREXT=bz2
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

sh Configure -des -Dprefix=/tools -Dlibs=-lm

make

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.22.0
cp -Rv lib/* /tools/lib/perl5/5.22.0

cd ..

rm -r -f $SRCDIR

