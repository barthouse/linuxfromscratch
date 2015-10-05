# build-check.sh

SRCDIR=check-0.10.0

# tar -zxvf check-0.10.0.tar.gz

cd $SRCDIR

PKG_CONFIG= ./configure --prefix=/tools

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

