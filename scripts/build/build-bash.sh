# build-bash.sh

SRCDIR=bash-4.3.30

tar -zxvf bash-4.3.30.tar.gz

cd $SRCDIR

./configure --prefix=/tools \
            --without-bash-malloc

make 

make tests

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

ln -sv bash /tools/bin/sh

cd ..

rm -r -f $SRCDIR

