mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

echo 'verifying compiler and linker'

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

echo 'verifying start files'

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

echo 'verifying correct header file search'

grep -B1 '^ /usr/include' dummy.log

echo 'verifying new linker is being used with correct search path'

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

echo 'make sure we are using the right libc'

grep "/lib.*/libc.so.6 " dummy.log

echo 'make sure gcc is using the right linker'

grep found dummy.log

echo 'cleaning up'

rm -v dummy.c a.out dummy.log

