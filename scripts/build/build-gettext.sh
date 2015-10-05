PKGNAME=gettext
PKGVER=0.19.5.1
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.xz

# -z for .gz
# tar -zxvf $TARFILE

# -J for .xz
# tar -Jxvf $TARFILE

cd $SRCDIR

cd gettext-tools

# EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

cd ..

cd ..

rm -r -f $SRCDIR

