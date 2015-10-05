PKGNAME=flex
PKGVER=2.5.39
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

sed -i -e '/test-bison/d' tests/Makefile.in

./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39

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

ln -sv flex /usr/bin/lex

cd ..

rm -r -f $SRCDIR

