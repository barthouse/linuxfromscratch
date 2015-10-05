# build-coreutils.sh

TARFILE=coreutils-8.24.tar.xz
SRCDIR=coreutils-8.24

# -z for .gz
# tar -zxvf $TARFILE

# -J for .xz
tar -Jxvf $TARFILE

cd $SRCDIR

./configure --prefix=/tools --enable-install-program=hostname

make 

make RUN_EXPENSIVE_TESTS=yes check

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
