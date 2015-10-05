PKGNAME=gcc
PKGVER=5.2.0
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

# mkdir -v ../gcc-build
cd ../gcc-build

SED=sed
#../gcc-5.2.0/configure --prefix=/usr --enable-laguages=c,c++ \
#                      --disable-multilib --disable-bootstrap \
#                      --with-system-zlib

#make

#ulimit -s 32768

#make -k check

#../gcc-5.2.0/contrib/test_summary | grep -A7 Summ

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

ln -sv ../usr/bin/cpp /lib

ln -sv gcc /usr/bin/cc

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/5.2.0/liblto_plugin.so /usr/lib/bfd-plugins/

echo 'verifying tool chain'

echo 'int main() {}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

echo 'check that we are using the correct start files'
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

echo 'verify compiler is search for headers correctly'
grep -B4 '^ /usr/include' dummy.log

echo 'verify linker search paths'
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

echo 'verify we are using correct libc'
grep "/lib.*/libc.so.6 " dummy.log

echo 'verify correct dynamic linker'
grep found dummy.log

rm -v dummy.c a.out dummy.log

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

cd ..

rm -r -f gcc-build
rm -r -f $SRCDIR

