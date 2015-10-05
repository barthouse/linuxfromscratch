PKGNAME=coreutils
PKGVER=8.24
TAREXT=xz
SRCDIR=$PKGNAME-$PKGVER
TARFILE=$SRCDIR.tar.$TAREXT

case $TAREXT in
    "gz") tar -zxvf $TARFILE
          ;;
    "xz") tar -Jxvf $TARFILE
          ;;
    "bz2") tar -jxvf $TARFILE
           ;;
    *) echo "unrecognized tar extension"
       exit
       ;; 
esac

cd $SRCDIR

patch -Np1 -i ../coreutils-8.24-i18n-1.patch 
sed -i '/tests\/misc\/sort.pl/ d' Makefile.in

FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

make

make NON_ROOT_USERNAME=nobody check-root

echo "dummy:x:1000:nobody" >> /etc/group

chown -Rv nobody 

su nobody -s /bin/bash \
          -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

sed -i '/dummy/d' /etc/group

echo "Continue?"
select yn in "y" "n"; do
    case $yn in
        "y" ) break;;
        "n" ) exit;;
    esac
done

make install

mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

mv -v /usr/bin/{head,sleep,nice,test,[} /bin

cd ..

rm -r -f $SRCDIR
