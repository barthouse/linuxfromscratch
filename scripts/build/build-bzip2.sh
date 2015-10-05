# build-bzip2.sh

TARFILE=bzip2-1.0.6.tar.gz
SRCDIR=bzip2-1.0.6

tar -zxvf $TARFILE

cd $SRCDIR

# ./configure --prefix=/tools

make 

make PREFIX=/tools install

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cd ..

rm -r -f $SRCDIR
