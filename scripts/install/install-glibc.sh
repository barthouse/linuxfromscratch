PKGNAME=glibc
PKGVER=2.22
TAREXT=xz

DIR="`dirname \"$0\"`"

source $DIR/dosetup.sh

source $DIR/dotar.sh

patch -Np1 -i ../glibc-2.22-fhs-1.patch 1> $PATCHLOG 2> $PATCHERR

patch -Np1 -i ../glibc-2.22-upstream_i386_fix-1.patch 1> $PATCHLOG 2> $PATCHERR

mkdir -v ../glibc-install
cd ../glibc-install

echo 'CONFIG'

../glibc-2.22/configure    \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=2.6.32 \
    --enable-obsolete-rpc  \
            1> $CONFIGLOG 2> $CONFIGERR

echo 'MAKE'

make 1> $MAKELOG 2> $MAKEERR

echo 'MAKE TESTS'

make check 1> $TESTLOG 2> $TESTERR

echo 'MAKE INSTALL'

touch /etc/ld.so.conf

make install 1> $INSTALLLOG 2> $INSTALLERR

cp -v ../glibc-2.22/nscd/nscd.conf /etc/nscd.conf 1>> $INSTALLLOG 2>> $INSTALLERR
mkdir -pv /var/cache/nscd 1>> $INSTALLLOG 2>> $INSTALLERR

mkdir -pv /usr/lib/locale 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i de_DE -f ISO-8859-1 de_DE 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i de_DE -f UTF-8 de_DE.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i en_GB -f UTF-8 en_GB.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i en_HK -f ISO-8859-1 en_HK 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i en_PH -f ISO-8859-1 en_PH 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i en_US -f ISO-8859-1 en_US 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i en_US -f UTF-8 en_US.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i es_MX -f ISO-8859-1 es_MX 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i fa_IR -f UTF-8 fa_IR 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i fr_FR -f ISO-8859-1 fr_FR 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i it_IT -f ISO-8859-1 it_IT 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i it_IT -f UTF-8 it_IT.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i ja_JP -f EUC-JP ja_JP 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8 1>> $INSTALLLOG 2>> $INSTALLERR
localedef -i zh_CN -f GB18030 zh_CN.GB18030 1>> $INSTALLLOG 2>> $INSTALLERR

cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

tar -xf ../tzdata2015f.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

cp -v /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv /etc/ld.so.conf.d

source $DIR/docleanup.sh
