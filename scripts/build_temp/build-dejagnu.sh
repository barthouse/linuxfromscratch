# build-dejagnu.sh

tar -zxvf dejagnu-1.5.3.tar.gz

cd dejagnu-1.5.3

./configure --prefix=/tools

make install

make check

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cd ..

rm -r -f dejagnu-1.5.3

