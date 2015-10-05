tar -zxvf tcl-core8.6.4-src.tar.gz

cd tcl8.6.4

cd unix

./configure --prefix=/tools

make

TZ=UTC make test

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

chmod -v u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ..

rm -r -f tcl8.6.4

