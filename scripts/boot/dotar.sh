echo 'TAR'

case $TAREXT in
    "gz") tar -zxvf $TARFILE 1> $TARLOG 2> $TARERR
          ;;
    "xz") tar -Jxvf $TARFILE 1> $TARLOG 2> $TARERR
          ;;
    "bz2") tar -jxvf $TARFILE 1> $TARLOG 2> $TARERR
          ;;
    *) echo "ERROR: unrecognized tar extension"
          exit;; 
esac

cd $SRCDIR


