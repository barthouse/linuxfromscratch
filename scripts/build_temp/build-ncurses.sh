# build-ncurses.sh

SRCDIR=ncurses-6.0

tar -zxvf ncurses-6.0.tar.gz

cd $SRCDIR

sed -i s/mawk// configure

./configure --prefix=/tools \
            --with-shared \
            --without-debug \
            --without-ada \
            --enable-widec \
            --enable-overwrite

make 

make install

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cd ..

rm -r -f $SRCDIR

