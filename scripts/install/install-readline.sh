PKGNAME=readline
PKGVER=6.3
TAREXT=gz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'PATCH'

patch -Np1 -i ../readline-6.3-upstream_fixes-3.patch \
    1> $PATCHLOG 2> $PATCHERR

echo 'CONFIG'

sed -i '/MV.*old/d' Makefile.in \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i '/{OLDSUFF}/c:' support/shlib-install \
    1>> $CONFIGLOG 2>> $CONFIGERR

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/readline-6.3 \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make SHLIB_LIBS=-lncurses \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE INSTALL'

make SHLIB_LIBS=-lncurses install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/lib/lib{readline,history}.so.* /lib \
    1>> $INSTALLLOG 2>> $INSTALLERR

if [ -h /usr/lib/libreadline.so ]
then
    ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) \
         /usr/lib/libreadline.so \
        1>> $INSTALLLOG 2>> $INSTALLERR

    ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) \
        /usr/lib/libhistory.so \
        1>> $INSTALLLOG 2>> $INSTALLERR
else
    echo 'Build failed'
fi

install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-6.3 \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
