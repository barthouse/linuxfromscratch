PKGNAME=coreutils
PKGVER=8.24
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

echo 'CONFIG'

patch -Np1 -i ../coreutils-8.24-i18n-1.patch \
    1> $CONFIGLOG 2> $CONFIGERR

sed -i '/tests\/misc\/sort.pl/ d' Makefile.in \
    1>> $CONFIGLOG 2>> $CONFIGERR

FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime \
    1>> $CONFIGLOG 2>> $CONFIGERR

echo 'MAKE'

make \
    1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make NON_ROOT_USERNAME=nobody check-root \
    1> $TESTLOG 2> $TESTERR

echo "dummy:x:1000:nobody" >> /etc/group \
    1>> $TESTLOG 2>> $TESTERR

chown -Rv nobody . \
    1>> $TESTLOG 2>> $TESTERR

su nobody -s /bin/bash \
          -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check" \
    1>> $TESTLOG 2>> $TESTERR

sed -i '/dummy/d' /etc/group \
    1>> $TESTLOG 2>> $TESTERR

echo 'MAKE INSTALL'

make install \
    1> $INSTALLLOG 2> $INSTALLERR

mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/chroot /usr/sbin \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8 \
    1>> $INSTALLLOG 2>> $INSTALLERR

sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8 \
    1>> $INSTALLLOG 2>> $INSTALLERR

mv -v /usr/bin/{head,sleep,nice,test,[} /bin \
    1>> $INSTALLLOG 2>> $INSTALLERR

source $DIR/docleanup.sh
