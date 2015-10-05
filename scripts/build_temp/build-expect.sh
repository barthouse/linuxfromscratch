# build-expect.sh

# VERSION=5.45
# TARFILE=expect$(VERSION).tar.gz

tar -zxvf expect5.45.tar.gz

cd expect5.45

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include

make

make test

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make SCRIPTS="" install

cd ..

rm -r -f expect5.45

