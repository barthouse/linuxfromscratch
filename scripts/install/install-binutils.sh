PKGNAME=binutils
PKGVER=2.25.1
TAREXT=bz2
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

case $TAREXT in
    "gz") tar -zxvf $TARFILE
          ;;
    "xz") tar -Jxvf $TARFILE
          ;;
    "bz2") echo tar -jxvf $TARFILE
           ;;
    *) echo "unrecognized tar extension"
       exit
       ;; 
esac

cd $SRCDIR

echo 'verifying PTYs are working properly'

expect -c "spawn ls"

# mkdir -v ../binutils-build
cd ../binutils-build

../binutils-2.25.1/configure --prefix=/usr --enable-shared --disable-werror

make tooldir=/usr

make check

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make tooldir=/usr install

cd ..

rm -r -f binutils-build
rm -r -f $SRCDIR

