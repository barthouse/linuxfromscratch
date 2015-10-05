PKGNAME=gmp
PKGVER=6.0.0
TAREXT=xz
SRCDIR=$PKGNAME-$PKGVER
TARFILE=gmp-6.0.0a.tar.$TAREXT

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

./configure --prefix=/usr --enable-cxx --disable-static \
            --docdir=/usr/share/doc/gmp-6.0.0a

make
make html

make check 2>&1 | tee gmp-check-log

echo 'checking test results'

awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log

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

