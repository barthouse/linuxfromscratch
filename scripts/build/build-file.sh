# build-file.sh

TARFILE=file-5.24.tar.gz
SRCDIR=file-5.24

# -z for .gz
tar -zxvf $TARFILE

# -J for .xz
# tar -Jxvf $TARFILE

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

