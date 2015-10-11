PKGNAME=gcc
PKGVER=5.2.0
TAREXT=bz2

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

source $DIR/dobuilddir.sh

echo 'CONFIG'

SED=sed                       \
../gcc-5.2.0/configure        \
     --prefix=/usr            \
     --enable-languages=c,c++ \
     --disable-multilib       \
     --disable-bootstrap      \
     --with-system-zlib       \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

ulimit -s 32768

echo 'MAKE TESTS'

make -k check 1> $TESTLOG 2> $TESTERR

../gcc-5.2.0/contrib/test_summary | grep -A7 Summ 1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make install 1> $INSTALLLOG 2> $INSTALLERR

ln -sv ../usr/bin/cpp /lib 1>> $INSTALLLOG 2>> $INSTALLERR

ln -sv gcc /usr/bin/cc 1>> $INSTALLLOG 2>> $INSTALLERR

install -v -dm755 /usr/lib/bfd-plugins 1>> $INSTALLLOG 2>> $INSTALLERR
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/5.2.0/liblto_plugin.so /usr/lib/bfd-plugins/ 1>> $INSTALLLOG 2>> $INSTALLERR

echo 'verifying tool chain'

echo 'int main() {}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
echo 'should get "[Requesting program interpreter: /lib/ld-linux.so.2]"'

echo 'check that we are using the correct start files'
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
echo 'should get:'
echo '/usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crt1.o succeeded'
echo '/usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crti.o succeeded'
echo '/usr/lib/gcc/i686-pc-linux-gnu/5.2.0/../../../crtn.o succeeded'

echo 'verify compiler is search for headers correctly'
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
echo 'should get:'
echo 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib32")'
echo 'SEARCH_DIR("/usr/local/lib32")'
echo 'SEARCH_DIR("/lib32")'
echo 'SEARCH_DIR("/usr/lib32")'
echo 'SEARCH_DIR("/usr/i686-pc-linux-gnu/lib")'
echo 'SEARCH_DIR("/usr/local/lib")'
echo 'SEARCH_DIR("/lib")'
echo 'SEARCH_DIR("/usr/lib");'

echo 'verify linker search paths'
grep "/lib.*/libc.so.6 " dummy.log
echo 'should get "attempt to open /lib/libc.so.6 succeeded"'

echo 'verify correct dynamic linker'
grep found dummy.log
echo 'should get "found ld-linux.so.2 at /lib/ld-linux.so.2"'

rm -v dummy.c a.out dummy.log

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

source $DIR/docleanup.sh
